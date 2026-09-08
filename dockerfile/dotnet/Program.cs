var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => new { message = "Hello from .NET 10 on Linux Docker!", timestamp = DateTime.UtcNow });
app.MapGet("/healthz", () => Results.Ok(new { status = "Healthy" }));

app.Run();
