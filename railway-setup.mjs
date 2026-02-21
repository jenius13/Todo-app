#!/usr/bin/env node
import os from "os";
import fs from "fs";

// Ensure data directory exists
const dataDir = ".railway";
if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir, { recursive: true });
}

console.log("✅ Railway setup completed");
