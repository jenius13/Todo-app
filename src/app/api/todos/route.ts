import { NextRequest, NextResponse } from "next/server";
import Database from "better-sqlite3";
import path from "path";

// Initialize database
let db: Database.Database;

function getDb() {
  if (!db) {
    const dbPath = path.join(process.cwd(), "data", "todos.db");
    db = new Database(dbPath);
    db.pragma("journal_mode = WAL");

    // Create table if it doesn't exist
    db.exec(`
      CREATE TABLE IF NOT EXISTS todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        completed INTEGER DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    `);
  }
  return db;
}

export async function GET() {
  try {
    const db = getDb();
    const todos = db
      .prepare("SELECT * FROM todos ORDER BY created_at DESC")
      .all();
    return NextResponse.json(todos);
  } catch (error) {
    console.error("Error fetching todos:", error);
    return NextResponse.json({ error: "Failed to fetch todos" }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const { title } = await request.json();

    if (!title || typeof title !== "string") {
      return NextResponse.json(
        { error: "Title is required" },
        { status: 400 }
      );
    }

    const db = getDb();
    const result = db
      .prepare("INSERT INTO todos (title, completed) VALUES (?, ?)")
      .run(title, 0);

    const todo = db
      .prepare("SELECT * FROM todos WHERE id = ?")
      .get(result.lastInsertRowid);

    return NextResponse.json(todo, { status: 201 });
  } catch (error) {
    console.error("Error creating todo:", error);
    return NextResponse.json(
      { error: "Failed to create todo" },
      { status: 500 }
    );
  }
}
