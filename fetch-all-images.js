const { randomInt } = require("crypto");
const fs = require("fs");
const path = require("path");
const { stringify } = require("querystring");

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

// let endpointUrl = args[3];

const files = fs.readdirSync(folderPath).filter((filename) => {
  const filepath = path.join(folderPath, filename);
  const fileExtention = path.extname(filepath).toLowerCase();
  return imageExtensions.includes(fileExtention);
});

console.log("begining to fetch all images...");

let filesSent = 0;
for (let filename of files) {
  const imageBytes = fs.readFileSync(path.join(folderPath, filename));
  fetch("http://localhost:8080/posters/upload", {
    method: "POST",
    headers: {
      "Content-Type": "multipart/form-data", // Not necessary when using FormData
    },
    body: imageBytes,
  }).then(() => {
    fetch("http://localhost:8080/videos/save/metadata", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: composeRandomMetadata(),
    });
  });
}

console.log("sucessfully finished. ", filesSent, " images was sent to server.");

function composeRandomMetadata() {
  const loremText =
    "Quisque fermentum diam a viverra rutrum. Nam fermentum aliquam lacus, at dapibus nulla dignissim nec. Quisque vitae ipsum sodales orci venenatis ornare eu rutrum mi. Aenean eget tortor malesuada, volutpat est quis, dictum libero. Sed hendrerit nisl nisi, eget feugiat nibh volutpat sed. Integer tristique mauris vitae turpis iaculis, eu lacinia justo auctor. Vivamus elit sapien, tempus eget lacus sit amet, vestibulum sodales massa. Cras faucibus dui a bibendum ultrices. Nulla viverra maximus fermentum. Suspendisse vitae varius nunc, quis mattis diam.".split(
      " ",
    );
  const ageVariants = [0, 6, 12, 16, 18];

  let wordsAmount = randomInt(1, 5);
  let title = "";
  let subGenres = "";
  for (let i = 0; i < wordsAmount; i++) {
    if (i == wordsAmount - 1) {
      title = title.concat(loremText[randomInt(0, randomInt.length)]);
      subGenres = subGenres.concat(loremText[randomInt(0, randomInt.length)]);
      break;
    }
    title = title.concat(loremText[randomInt(0, randomInt.length)]).concat(" ");
    subGenres = subGenres
      .concat(loremText[randomInt(0, randomInt.length)])
      .concat(",");
  }
  return {
    id: randomInt(500, 10000),
    title: title,
    releaseDate: "2011-08-12T20:17:46.384Z",
    country: loremText[randomInt(0, randomInt.length - 1)],
    mainGenre: loremText[randomInt(0, randomInt.length - 1)],
    subGenres: subGenres,
    age: ageVariants[randomInt(0, ageVariants.length - 1)],
    rating: (10 * Math.random()).toFixed(2),
    posterId: randomInt(0, 42379249),
    videoId: randomInt(0, 42379249),
  };
}
