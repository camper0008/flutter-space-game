import { Game, tick } from "./game";
import { vec2d } from "./Vector2d";

const rgb = (red: number, green = red, blue = green, alpha = 1) =>
    `rgba(${red},${green},${blue},${alpha})`;

const downloadImage = (src: string): Promise<HTMLImageElement> => {
    const image = new Image();
    image.src = src;
    return new Promise((resolve) => {
        image.addEventListener("load", () => resolve(image));
    });
};

const render = (
    game: Game,
    canvas: HTMLCanvasElement,
    graphics: CanvasRenderingContext2D,
    images: {
        float: HTMLImageElement;
        throttle: HTMLImageElement;
    },
) => {
    const image =
        game.buttons.left || game.buttons.right || game.buttons.throttle
            ? images.throttle
            : images.float;
    graphics.fillStyle = rgb(20, 20, 30);
    graphics.fillRect(0, 0, 800, 800);
    graphics.save();
    graphics.translate(game.rocket.position.x, game.rocket.position.y);
    graphics.rotate(-game.rocket.angle);
    const size = ((s) => vec2d(s, (image.height / image.width) * s))(100);
    graphics.drawImage(image, -size.x / 2, -size.y / 2, size.x, size.y);
    graphics.restore();
};

const main = async () => {
    const canvas = document.querySelector<HTMLCanvasElement>("#game")!;
    canvas.width = 800;
    canvas.height = 800;
    const graphics = canvas.getContext("2d")!;
    graphics.imageSmoothingEnabled = true;
    graphics.imageSmoothingQuality = "high";
    const game: Game = {
        buttons: {
            left: false,
            right: false,
            throttle: false,
        },
        rocket: {
            height: 10,
            radius: 5,
            mass: 500,
            position: vec2d(100, 100),
            velocity: vec2d(),
            angle: 0,
            angularVelocity: 0,
            engine: {
                absoluteForce: 5000,
                radius: 5,
                turnAngle: (5 / 180) * Math.PI,
                // turnAngle: Math.PI / 4,
                angle: 0,
            },
        },
    };

    const changeKeyState = (key: string, to: boolean) => {
        switch (key) {
            case "ArrowRight":
                game.buttons.right = to;
                break;
            case "ArrowLeft":
                game.buttons.left = to;
                break;
            case "ArrowUp":
                game.buttons.throttle = to;
                break;
        }
    };

    document.body.addEventListener("keydown", ({ key }) =>
        changeKeyState(key, true),
    );

    document.body.addEventListener("keyup", ({ key }) =>
        changeKeyState(key, false),
    );

    const images = {
        float: await downloadImage("sus-25.png"),
        throttle: await downloadImage("sus-25-flame.png"),
    };

    let before = Date.now();
    setInterval(() => {
        const now = Date.now();
        const deltaT = (now - before) / 1000;
        before = now;
        render(game, canvas, graphics, images);
        tick(game, deltaT);
    }, 10);
};

main();
