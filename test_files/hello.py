import os
import sys
from PIL import Image

def create_gif(image_paths, output_path="output.gif", duration=500, loop=0):
    """
    Create a GIF from a list of image paths.

    :param image_paths: List of image file paths (ordered)
    :param output_path: Output GIF file name
    :param duration: Time between frames in milliseconds
    :param loop: Number of loops (0 = infinite)
    """

    if not image_paths:
        raise ValueError("No images provided.")

    frames = []

    for path in image_paths:
        if not os.path.exists(path):
            raise FileNotFoundError(f"Image not found: {path}")

        img = Image.open(path)

        # Convert all images to RGB to avoid mode mismatch issues
        if img.mode != "RGB":
            img = img.convert("RGB")

        frames.append(img)

    # Save as GIF
    frames[0].save(
        output_path,
        save_all=True,
        append_images=frames[1:],
        duration=duration,
        loop=loop
    )

    print(f"GIF saved to {output_path}")


def main():
    if len(sys.argv) < 3:
        print("Usage:")
        print("  python make_gif.py output.gif img1.jpg img2.jpg img3.png ...")
        sys.exit(1)

    output_path = sys.argv[1]
    image_paths = sys.argv[2:]

    create_gif(image_paths, output_path)


if __name__ == "__main__":
    main()
