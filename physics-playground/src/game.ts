import { either } from "./util";
import { vec2d, Vector2d } from "./Vector2d";

export type Game = {
    buttons: {
        left: boolean;
        right: boolean;
        throttle: boolean;
    };
    rocket: {
        readonly height: number;
        readonly radius: number;
        readonly mass: number;
        position: Vector2d;
        velocity: Vector2d;
        angle: number;
        angularVelocity: number;
        engine: {
            readonly absoluteForce: number;
            readonly radius: number;
            readonly turnAngle: number;
        };
    };
};

const cylinderMomentOfIntertia = (
    height: number,
    radius: number,
    mass: number,
): number => {
    // Moment of inertia of a solid cylinder
    // https://en.wikipedia.org/wiki/List_of_moments_of_inertia
    // I_x = 1/12m(3r^2 + h^2)
    // I_x = (1 / 12) * m * (3 * r ** 2 + h ** 2)
    // I_x [kg * m^2] = (1 / 12) * m [kg] * (3 * r [m] ** 2 + h [m] ** 2)
    // I_x [kg * m^2] = (1 / 12) * m [kg] * (3 * (r ** 2) [m^2] + (h ** 2) [m^2])
    // I_x [kg * m^2] = (1 / 12) * m [kg] * (3 * r ** 2 + h ** 2) [m^2]
    // I_x [kg * m^2] = ((1 / 12) * m * (3 * r ** 2 + h ** 2)) [kg * m^2]
    // kg * m^2 = kg * m^2
    const momentOfIntertia = (1 / 12) * mass * (3 * radius ** 2 + height ** 2);
    return momentOfIntertia;
};

const torque = (
    absoluteForce: number,
    radius: number,
    angle: number,
): number => {
    // https://media.discordapp.net/attachments/937814499182936125/990727172702494770/unknown.png
    // https://orbithtxa.systime.dk/?id=299
    // M = r * F * sin(A)
    // M [N * m] = r [m] * F [N] * sin(A)
    // M [N * m] = (r * F * sin(A)) [N * m]
    const torge = radius * absoluteForce * Math.sin(angle);
    return torge;
};

const throttling = (game: Game): boolean =>
    game.buttons.left || game.buttons.right || game.buttons.throttle;

const thrustAngle = (game: Game): number => {
    return either(
        game.buttons.right,
        game.buttons.left,
        -game.rocket.engine.turnAngle,
        game.rocket.engine.turnAngle,
        0,
    );
};

export const thrustForce = (
    rocketAngle: number,
    engineRadius: number,
    absoluteForce: number,
    engineAngle: number,
): Vector2d => {
    // TODO: something about -torque
    const radiusUnitVector = vec2d(
        Math.sin(rocketAngle + Math.PI),
        Math.cos(rocketAngle + Math.PI),
    );
    const thrustForce = radiusUnitVector.copy().multiplyN(absoluteForce);
    return thrustForce;
};

export const tick = (game: Game, deltaT: number) => {
    const thrustTorque = torque(
        game.rocket.engine.absoluteForce,
        game.rocket.engine.radius,
        thrustAngle(game),
    );
    const resultingTorque = [thrustTorque].reduce((acc, v) => acc + v, 0);

    const momentOfInteria = cylinderMomentOfIntertia(
        game.rocket.height,
        game.rocket.radius,
        game.rocket.mass,
    );

    const rotationalAcceleration = (resultingTorque / momentOfInteria) * deltaT;
    game.rocket.angularVelocity += rotationalAcceleration;
    game.rocket.angle += game.rocket.angularVelocity * deltaT;

    const resultingForce = [
        throttling(game)
            ? thrustForce(
                  game.rocket.angle,
                  game.rocket.engine.radius,
                  game.rocket.engine.absoluteForce,
                  thrustAngle(game),
              )
            : vec2d(),
    ].reduce((acc, v) => acc.add(v), vec2d());
    const transitionalAcceleration = resultingForce
        .divideN(game.rocket.mass)
        .multiplyN(deltaT);
    game.rocket.velocity.add(transitionalAcceleration);
    game.rocket.position.add(game.rocket.velocity.copy().multiplyN(deltaT));
};
