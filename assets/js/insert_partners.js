const fs = require("fs");

let partnersJson = fs.readFileSync("./priv/static/data/pdvs.json", "utf8");
let partners = JSON.parse(partnersJson);
// console.log(partners);
for (let partner of partners["pdvs"]) {
  fetch("http://localhost:4000/api/partner", {
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    method: "POST",
    body: JSON.stringify(partner),
  });
}
