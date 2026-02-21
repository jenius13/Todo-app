# Todo App

A full-stack Todo application built with Next.js, TypeScript, and SQLite, deployed on Railway.

## Features

- ✅ Add, edit, and delete todos
- ✅ Mark todos as complete/incomplete
- ✅ Persistent storage with SQLite
- ✅ Beautiful, responsive UI with Tailwind CSS
- ✅ Real-time updates
- ✅ API-based architecture

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn

### Installation

```bash
# Install dependencies
npm install

# Create data directory
mkdir -p data

# Run development server
npm run dev
```

Visit `http://localhost:3000` to see the application.

### Building for Production

```bash
npm run build
npm start
```

## Project Structure

```
src/
├── app/
│   ├── api/
│   │   └── todos/          # Todo API routes
│   │       ├── route.ts    # GET/POST endpoints
│   │       └── [id]/       # Dynamic routes
│   │           └── route.ts # PUT/DELETE endpoints
│   ├── globals.css         # Global styles
│   ├── layout.tsx          # Root layout
│   └── page.tsx            # Main page
```

## API Endpoints

- `GET /api/todos` - Get all todos
- `POST /api/todos` - Create a new todo
- `PUT /api/todos/[id]` - Update todo completion status
- `DELETE /api/todos/[id]` - Delete a todo

## Deployment on Railway

### 1. Create a Railway Account

Visit https://railway.app and sign up.

### 2. Connect Your Repository

1. Push this project to GitHub
2. Go to Railway Dashboard
3. Click "New Project" → "Deploy from GitHub"
4. Select your repository

### 3. Configure Environment Variables

In Railway dashboard:
- No additional environment variables needed (SQLite is used by default)
- Railway will automatically set `NODE_ENV=production`

### 4. Deploy

1. Railway will detect the Next.js project automatically
2. It will run `npm run build` 
3. Then `npm start`
4. Your app will be live at the provided Railway URL

### 5. Data Persistence

The SQLite database file (`todos.db`) will be stored in the `/data` directory. Note that Railway's filesystem is ephemeral, so consider using PostgreSQL for production:

```bash
npm install pg
```

Then update the API routes to use PostgreSQL connection.

## Environment Variables

Create a `.env.local` file for local development (optional):

```
# Optional: Database URL for PostgreSQL
DATABASE_URL=your_database_url_here
```

## Technologies Used

- **Frontend**: React, Next.js, TypeScript
- **Backend**: Next.js API Routes
- **Database**: SQLite (with optional PostgreSQL support)
- **Styling**: Tailwind CSS
- **HTTP Client**: Axios

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## License

MIT
