const fs = require("fs");
class Game {
  constructor() {
    this.data = fs
      .readFileSync("data.txt", "utf-8")
      .split("\n")
      .map((line) => line.trim())
      .filter((line) => line !== "");
    this.proxies = fs
      .readFileSync("proxy.txt", "utf-8")
      .split("\n")
      .map((line) => line.trim())
      .filter((line) => line !== "");

    const licenses = fs
      .readFileSync("license.txt", "utf-8")
      .split("\n")
      .map((line) => line.trim())
      .filter((line) => line !== "");
    if (licenses.length === 0) {
      throw new Error("Không có key, liên hệ telegram để được cấp license.");
    }
    this.license = licenses[0];
  }
  async run() {}
}

if (require.main === module) {
  const game = new Game();
  game.run().catch((err) => {
    console.error(err?.message);
    process.exit(1);
  });
}
