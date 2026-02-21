import { NextRequest, NextResponse } from "next/server";
import Database from "better-sqlite3";
import path from "path";

function getDb() {
  const dbPath = path.join(process.cwd(), "data", "todos.db");
  const db = new Database(dbPath);
  return db;
}

export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const { completed } = await request.json();
    const id = parseInt(params.id, 10);

    const db = getDb();
    db.prepare("UPDATE todos SET completed = ? WHERE id = ?").run(completed ? 1 : 0, id);

    const todo = db.prepare("SELECT * FROM todos WHERE id = ?").get(id);

    if (!todo) {
      return NextResponse.json({ error: "Todo not found" }, { status: 404 });
    }

    return NextResponse.json(todo);
  } catch (error) {
    console.error("Error updating todo:", error);
    return NextResponse.json(
      { error: "Failed to update todo" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id, 10);

    const db = getDb();
    db.prepare("DELETE FROM todos WHERE id = ?").run(id);

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error("Error deleting todo:", error);
    return NextResponse.json(
      { error: "Failed to delete todo" },
      { status: 500 }
    );
  }
}
