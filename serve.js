const express = require('express');
const path = require('path');
const fs = require('fs');
const app = express();
const PORT = process.env.PORT || 5000;

// Middleware to log requests
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

// Define MIME types
app.use(express.static(path.join(__dirname, 'build/web'), {
  setHeaders: (res, filePath) => {
    if (filePath.endsWith('.js')) {
      res.setHeader('Content-Type', 'application/javascript');
    } else if (filePath.endsWith('.css')) {
      res.setHeader('Content-Type', 'text/css');
    } else if (filePath.endsWith('.html')) {
      res.setHeader('Content-Type', 'text/html');
    } else if (filePath.endsWith('.json')) {
      res.setHeader('Content-Type', 'application/json');
    } else if (filePath.endsWith('.wasm')) {
      res.setHeader('Content-Type', 'application/wasm');
    } else if (filePath.endsWith('.png')) {
      res.setHeader('Content-Type', 'image/png');
    } else if (filePath.endsWith('.jpg') || filePath.endsWith('.jpeg')) {
      res.setHeader('Content-Type', 'image/jpeg');
    } else if (filePath.endsWith('.svg')) {
      res.setHeader('Content-Type', 'image/svg+xml');
    } else if (filePath.endsWith('.ttf')) {
      res.setHeader('Content-Type', 'font/ttf');
    } else if (filePath.endsWith('.otf')) {
      res.setHeader('Content-Type', 'font/otf');
    } else if (filePath.endsWith('.woff')) {
      res.setHeader('Content-Type', 'font/woff');
    } else if (filePath.endsWith('.woff2')) {
      res.setHeader('Content-Type', 'font/woff2');
    }
    
    // Set caching headers
    res.setHeader('Cache-Control', 'public, max-age=3600');
  }
}));

// Handle root route
app.get('/', (req, res) => {
  const indexPath = path.join(__dirname, 'build/web/index.html');
  if (fs.existsSync(indexPath)) {
    res.sendFile(indexPath);
  } else {
    res.status(404).send('Build not found. Run "flutter build web" first.');
  }
});

// Fallback to index.html for all other routes (for Flutter web routing)
app.use((req, res) => {
  const indexPath = path.join(__dirname, 'build/web/index.html');
  if (fs.existsSync(indexPath)) {
    res.sendFile(indexPath);
  } else {
    res.status(404).send('Build not found. Run "flutter build web" first.');
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Server error:', err);
  res.status(500).send(`
    <html>
      <head>
        <title>Work Time Tracker - Server Error</title>
        <style>
          body { font-family: Arial, sans-serif; padding: 20px; text-align: center; }
          h1 { color: #e74c3c; }
          .error-box { 
            background-color: #f8f9fa;
            border-left: 5px solid #e74c3c;
            padding: 15px;
            margin: 20px auto;
            max-width: 600px;
            text-align: left;
          }
          .back-button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
          }
        </style>
      </head>
      <body>
        <h1>Something went wrong</h1>
        <div class="error-box">
          <p>The server encountered an error while processing your request.</p>
          <p>Please try refreshing the page or return to the home page.</p>
        </div>
        <a href="/" class="back-button">Return to Home</a>
      </body>
    </html>
  `);
});

// Check if build exists before starting server
const buildPath = path.join(__dirname, 'build/web');
if (!fs.existsSync(buildPath)) {
  console.warn('\x1b[33m%s\x1b[0m', 'Warning: Build directory not found! Run "flutter build web" first.');
  console.log('Starting server anyway, but you will see 404 errors until a build is available.');
}

// Start the server
const server = app.listen(PORT, '0.0.0.0', () => {
  console.log('\x1b[32m%s\x1b[0m', `✓ Flutter web server running on http://0.0.0.0:${PORT}`);
  console.log('Press Ctrl+C to stop the server');
});

// Handle server shutdown
process.on('SIGINT', () => {
  console.log('\n\x1b[33m%s\x1b[0m', 'Shutting down server...');
  server.close(() => {
    console.log('\x1b[32m%s\x1b[0m', 'Server successfully closed');
    process.exit(0);
  });
});