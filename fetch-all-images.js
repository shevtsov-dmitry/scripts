const fs = require("fs");
const path = require("path");

const args = process.argv;
if (args.length !== 4) {
  console.error(
    "You need to specify 2 arguments: \
    1. Folder path with images. \
    2. Fetch destination. \
    Example: fetch-all-images . http://localhost:8080/images/save",
  );
  return;
}

let folderPath = args[2];

if (folderPath == ".") {
  folderPath = process.cwd();
}
fs.access(folderPath, fs.constants.R_OK, (err) => {
  if (!err) {
    return;
  }
  if (err.code === "EACCES") {
    console.error("Access denied to the directory:", folderPath);
  } else if (err.code === "ENOENT") {
    console.error("Directory does not exist:", folderPath);
  } else {
    console.error("Error accessing directory:", err);
  }
});

const imageExtensions = [
  ".jpg",
  ".jpeg",
  ".png",
  ".gif",
  ".bmp",
  ".tiff",
  ".svg",
];

const files = fs.readdirSync(folderPath).filter((file) => {
  const filepath = path.join(folderPath, file);
  const fileExtention = path.extname(filepath).toLowerCase();
  return imageExtensions.includes(fileExtention);
});
