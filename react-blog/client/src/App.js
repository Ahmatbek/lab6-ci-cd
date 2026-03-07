function App() {
  const posts = [
    { id: 1, title: "Learning Docker", content: "Multi-stage builds" },
    { id: 2, title: "Docker Best Practices", content: "Optimizing images" }
  ];

  return (
    <div style={{ maxWidth: 800, margin: "50px auto", fontFamily: "Arial" }}>
      <h1>📝 Docker Blog</h1>

      {posts.map(post => (
        <div key={post.id} style={{ border: "1px solid #ddd", padding: 20, margin: 10 }}>
          <h2>{post.title}</h2>
          <p>{post.content}</p>
        </div>
      ))}

    </div>
  );
}

export default App;
