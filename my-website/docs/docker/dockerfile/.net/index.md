# .NET/C# Projects with Docker

Tổng hợp các loại project .NET/C# phổ biến với Dockerfile tương ứng.

## 1. Console Application

### Program.cs

```csharp
using System;
using System.Threading;
using System.Threading.Tasks;

namespace HelloWorldConsole
{
    class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("Hello World from .NET Console App!");
            Console.WriteLine("Application is running...");

            // Keep running with periodic messages
            while (true)
            {
                Console.WriteLine($"Current time: {DateTime.Now:yyyy-MM-dd HH:mm:ss}");
                await Task.Delay(10000);
            }
        }
    }
}
```

### HelloWorldConsole.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
  </PropertyGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/out .
CMD ["dotnet", "HelloWorldConsole.dll"]
```

## 2. ASP.NET Core Web API

### Program.cs

```csharp
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseRouting();
app.MapControllers();

app.MapGet("/", () => new { Message = "Hello World from ASP.NET Core!" });

app.Run();
```

### Controllers/HelloController.cs

```csharp
using Microsoft.AspNetCore.Mvc;

namespace WebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HelloController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new { Message = "Hello World from Web API!", Status = "Success" });
        }

        [HttpGet("health")]
        public IActionResult Health()
        {
            return Ok(new { Status = "Healthy", Framework = "ASP.NET Core", Timestamp = DateTime.UtcNow });
        }

        [HttpPost("echo")]
        public IActionResult Echo([FromBody] EchoRequest request)
        {
            return Ok(new { Echo = $"You said: {request.Message}" });
        }
    }

    public class EchoRequest
    {
        public string Message { get; set; } = string.Empty;
    }
}
```

### WebApi.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
  </ItemGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "WebApi.dll"]
```

## 3. ASP.NET Core MVC

### Program.cs

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
```

### Controllers/HomeController.cs

```csharp
using Microsoft.AspNetCore.Mvc;
using MvcApp.Models;
using System.Diagnostics;

namespace MvcApp.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            ViewBag.Message = "Hello World from ASP.NET Core MVC!";
            return View();
        }

        public IActionResult About()
        {
            ViewBag.Message = "About page - Hello World!";
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
```

### Views/Home/Index.cshtml

```html
@{ ViewData["Title"] = "Home Page"; }

<div class="text-center">
  <h1 class="display-4">@ViewBag.Message</h1>
  <p>Welcome to ASP.NET Core MVC application.</p>
  <p>Current time: @DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")</p>
</div>
```

### MvcApp.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "MvcApp.dll"]
```

## 4. Blazor Server App

### Program.cs

```csharp
using BlazorApp.Data;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddSingleton<WeatherForecastService>();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.MapRazorPages();
app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
```

### Pages/Index.razor

```html
@page "/"

<PageTitle>Index</PageTitle>

<h1>Hello World from Blazor Server!</h1>

<p>Welcome to your new Blazor Server app.</p>

<div class="alert alert-info"><strong>Current Time:</strong> @currentTime</div>

<button class="btn btn-primary" @onclick="UpdateTime">Update Time</button>

@code { private string currentTime = DateTime.Now.ToString("yyyy-MM-dd
HH:mm:ss"); private void UpdateTime() { currentTime =
DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"); } protected override async Task
OnInitializedAsync() { // Update time every 5 seconds var timer = new
System.Timers.Timer(5000); timer.Elapsed += (sender, e) => { currentTime =
DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"); InvokeAsync(StateHasChanged); };
timer.Start(); } }
```

### Data/WeatherForecastService.cs

```csharp
namespace BlazorApp.Data
{
    public class WeatherForecastService
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public Task<WeatherForecast[]> GetForecastAsync(DateOnly startDate)
        {
            return Task.FromResult(Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = startDate.AddDays(index),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            }).ToArray());
        }
    }

    public class WeatherForecast
    {
        public DateOnly Date { get; set; }
        public int TemperatureC { get; set; }
        public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
        public string? Summary { get; set; }
    }
}
```

### BlazorApp.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "BlazorApp.dll"]
```

## 5. Web API with Entity Framework

### Program.cs

```csharp
using Microsoft.EntityFrameworkCore;
using WebApiEF.Data;
using WebApiEF.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseInMemoryDatabase("HelloWorldDB"));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Seed data
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    context.Users.Add(new User { Name = "Hello World User", Email = "hello@world.com" });
    context.SaveChanges();
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseRouting();
app.MapControllers();

app.Run();
```

### Data/AppDbContext.cs

```csharp
using Microsoft.EntityFrameworkCore;
using WebApiEF.Models;

namespace WebApiEF.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();
        }
    }
}
```

### Models/User.cs

```csharp
using System.ComponentModel.DataAnnotations;

namespace WebApiEF.Models
{
    public class User
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = string.Empty;

        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
```

### Controllers/UsersController.cs

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApiEF.Data;
using WebApiEF.Models;

namespace WebApiEF.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UsersController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.Users.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<User>> GetUser(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
                return NotFound();

            return user;
        }

        [HttpPost]
        public async Task<ActionResult<User>> CreateUser(User user)
        {
            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
        }
    }
}
```

### WebApiEF.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.EntityFrameworkCore.InMemory" Version="8.0.0" />
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
  </ItemGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "WebApiEF.dll"]
```

## 6. gRPC Service

### Program.cs

```csharp
using GrpcService.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddGrpc();

var app = builder.Build();

app.MapGrpcService<GreeterService>();
app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

app.Run();
```

### Protos/greet.proto

```protobuf
syntax = "proto3";

option csharp_namespace = "GrpcService";

package greet;

service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply);
  rpc SayHelloStream (HelloRequest) returns (stream HelloReply);
}

message HelloRequest {
  string name = 1;
}

message HelloReply {
  string message = 1;
}
```

### Services/GreeterService.cs

```csharp
using Grpc.Core;
using GrpcService;

namespace GrpcService.Services
{
    public class GreeterService : Greeter.GreeterBase
    {
        private readonly ILogger<GreeterService> _logger;

        public GreeterService(ILogger<GreeterService> logger)
        {
            _logger = logger;
        }

        public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
        {
            return Task.FromResult(new HelloReply
            {
                Message = $"Hello World from gRPC! Hi {request.Name}"
            });
        }

        public override async Task SayHelloStream(HelloRequest request, IServerStreamWriter<HelloReply> responseStream, ServerCallContext context)
        {
            for (int i = 0; i < 5; i++)
            {
                await responseStream.WriteAsync(new HelloReply
                {
                    Message = $"Hello World from gRPC Stream! Hi {request.Name} - Message {i + 1}"
                });

                await Task.Delay(1000, context.CancellationToken);
            }
        }
    }
}
```

### GrpcService.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <Protobuf Include="Protos\greet.proto" GrpcServices="Server" />
  </ItemGroup>

  <ItemGroup>
    <PackageReference Include="Grpc.AspNetCore" Version="2.57.0" />
  </ItemGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "GrpcService.dll"]
```

## 7. Worker Service

### Program.cs

```csharp
using WorkerService;

var builder = Host.CreateApplicationBuilder(args);
builder.Services.AddHostedService<Worker>();

var host = builder.Build();
host.Run();
```

### Worker.cs

```csharp
namespace WorkerService
{
    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;

        public Worker(ILogger<Worker> logger)
        {
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Hello World from Worker Service!");

            while (!stoppingToken.IsCancellationRequested)
            {
                _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
                _logger.LogInformation("Hello World - Processing background task...");

                // Simulate work
                await DoWork();

                await Task.Delay(10000, stoppingToken);
            }
        }

        private async Task DoWork()
        {
            // Simulate some work
            await Task.Delay(1000);
            _logger.LogInformation("Background work completed successfully!");
        }
    }
}
```

### WorkerService.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Worker">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <UserSecretsId>dotnet-WorkerService-12345</UserSecretsId>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.Extensions.Hosting" Version="8.0.0" />
  </ItemGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/out .
CMD ["dotnet", "WorkerService.dll"]
```

## 8. Minimal API

### Program.cs

```csharp
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<TodoDb>(opt => opt.UseInMemoryDatabase("TodoList"));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

var app = builder.Build();

app.MapGet("/", () => new { Message = "Hello World from Minimal API!" });

app.MapGet("/todos", async (TodoDb db) =>
    await db.Todos.ToListAsync());

app.MapGet("/todos/{id}", async (int id, TodoDb db) =>
    await db.Todos.FindAsync(id)
        is Todo todo
            ? Results.Ok(todo)
            : Results.NotFound());

app.MapPost("/todos", async (Todo todo, TodoDb db) =>
{
    db.Todos.Add(todo);
    await db.SaveChangesAsync();
    return Results.Created($"/todos/{todo.Id}", todo);
});

// Seed data
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<TodoDb>();
    db.Todos.Add(new Todo { Name = "Hello World Todo", IsComplete = false });
    db.SaveChanges();
}

app.Run();

class Todo
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public bool IsComplete { get; set; }
}

class TodoDb : DbContext
{
    public TodoDb(DbContextOptions<TodoDb> options) : base(options) { }
    public DbSet<Todo> Todos => Set<Todo>();
}
```

### MinimalApi.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore" Version="8.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.InMemory" Version="8.0.0" />
  </ItemGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "MinimalApi.dll"]
```

## 9. SignalR Hub

### Program.cs

```csharp
using SignalRApp.Hubs;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR();

var app = builder.Build();

app.UseDefaultFiles();
app.UseStaticFiles();

app.MapHub<ChatHub>("/chathub");

app.Run();
```

### Hubs/ChatHub.cs

```csharp
using Microsoft.AspNetCore.SignalR;

namespace SignalRApp.Hubs
{
    public class ChatHub : Hub
    {
        public async Task SendMessage(string user, string message)
        {
            await Clients.All.SendAsync("ReceiveMessage", user, $"Hello World! {message}");
        }

        public override async Task OnConnectedAsync()
        {
            await Clients.Caller.SendAsync("ReceiveMessage", "System", "Hello World from SignalR! Welcome to the chat.");
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            await Clients.All.SendAsync("ReceiveMessage", "System", "A user disconnected.");
            await base.OnDisconnectedAsync(exception);
        }
    }
}
```

### wwwroot/index.html

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Hello World SignalR Chat</title>
  </head>
  <body>
    <div>
      <h1>Hello World SignalR Chat</h1>
      <div id="messagesList"></div>
      <input type="text" id="userInput" placeholder="Your name" />
      <input type="text" id="messageInput" placeholder="Type a message..." />
      <button id="sendButton">Send</button>
    </div>

    <script src="https://unpkg.com/@microsoft/signalr@latest/dist/browser/signalr.min.js"></script>
    <script>
      const connection = new signalR.HubConnectionBuilder()
        .withUrl("/chathub")
        .build();

      connection
        .start()
        .then(function () {
          document.getElementById("sendButton").disabled = false;
        })
        .catch(function (err) {
          console.error(err.toString());
        });

      connection.on("ReceiveMessage", function (user, message) {
        const li = document.createElement("div");
        li.textContent = `${user}: ${message}`;
        document.getElementById("messagesList").appendChild(li);
      });

      document
        .getElementById("sendButton")
        .addEventListener("click", function (event) {
          const user = document.getElementById("userInput").value;
          const message = document.getElementById("messageInput").value;
          connection.invoke("SendMessage", user, message).catch(function (err) {
            console.error(err.toString());
          });
          event.preventDefault();
        });
    </script>
  </body>
</html>
```

### SignalRApp.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>
</Project>
```

### Dockerfile

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
CMD ["dotnet", "SignalRApp.dll"]
```

## 10. .NET MAUI App (Cross-platform)

### MauiProgram.cs

```csharp
using Microsoft.Extensions.Logging;

namespace MauiApp1
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                });

            builder.Services.AddMauiBlazorWebView();

#if DEBUG
            builder.Services.AddBlazorWebViewDeveloperTools();
            builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
```

### MainPage.xaml

```xml
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage x:Class="MauiApp1.MainPage"
             xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml">

    <ScrollView>
        <VerticalStackLayout Spacing="25" Padding="30,0" VerticalOptions="Center">

            <Image Source="dotnet_bot.png" HeightRequest="185" Aspect="AspectFit" />

            <Label x:Name="CounterLabel" Text="Hello World from .NET MAUI!" FontSize="18" HorizontalOptions="Center" />

            <Button x:Name="CounterBtn" Text="Click me" FontSize="18" Clicked="OnCounterClicked" HorizontalOptions="Center" />

        </VerticalStackLayout>
    </ScrollView>

</ContentPage>
```

### MainPage.xaml.cs

```csharp
namespace MauiApp1
{
    public partial class MainPage : ContentPage
    {
        int count = 0;

        public MainPage()
        {
            InitializeComponent();
        }

        private void OnCounterClicked(object sender, EventArgs e)
        {
            count++;

            if (count == 1)
                CounterBtn.Text = $"Clicked {count} time";
            else
                CounterBtn.Text = $"Clicked {count} times";

            CounterLabel.Text = $"Hello World from MAUI! Button clicked {count} times.";
        }
    }
}
```

### MauiApp1.csproj

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFrameworks>net8.0-android;net8.0-ios;net8.0-maccatalyst</TargetFrameworks>
    <OutputType>Exe</OutputType>
    <RootNamespace>MauiApp1</RootNamespace>
    <UseMaui>true</UseMaui>
    <SingleProject>true</SingleProject>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>

    <ApplicationTitle>MauiApp1</ApplicationTitle>
    <ApplicationId>com.companyname.mauiapp1</ApplicationId>
    <ApplicationDisplayVersion>1.0</ApplicationDisplayVersion>
    <ApplicationVersion>1</ApplicationVersion>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.Maui.Controls" Version="8.0.0" />
    <PackageReference Include="Microsoft.AspNetCore.Components.WebView.Maui" Version="8.0.0" />
    <PackageReference Include="Microsoft.Extensions.Logging.Debug" Version="8.0.0" />
  </ItemGroup>
</Project>
```

### Dockerfile (Linux/Android)

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Install Android SDK (for Android builds)
RUN apt-get update && apt-get install -y openjdk-11-jdk wget unzip
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
RUN dotnet workload install maui-android

COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -f net8.0-android -c Release -o out

FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/out .
CMD ["dotnet", "MauiApp1.dll"]
```

## Docker Compose Examples

### ASP.NET Core + SQL Server + Redis

```yaml
version: "3.8"
services:
  web:
    build: ./webapi
    ports:
      - "8080:8080"
    environment:
      - ConnectionStrings__DefaultConnection=Server=sqlserver;Database=MyApp;User Id=sa;Password=YourPassword123;TrustServerCertificate=True
      - Redis__ConnectionString=redis:6379
    depends_on:
      - sqlserver
      - redis

  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      SA_PASSWORD: "YourPassword123"
      ACCEPT_EULA: "Y"
    ports:
      - "1433:1433"
    volumes:
      - sqlserver_data:/var/opt/mssql

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"

volumes:
  sqlserver_data:
```

### Microservices Architecture

```yaml
version: "3.8"
services:
  gateway:
    build: ./ApiGateway
    ports:
      - "8080:8080"
    depends_on:
      - user-service
      - order-service

  user-service:
    build: ./UserService
    ports:
      - "8081:8080"
    environment:
      - ConnectionStrings__DefaultConnection=Server=sqlserver;Database=Users;User Id=sa;Password=YourPassword123;TrustServerCertificate=True
    depends_on:
      - sqlserver

  order-service:
    build: ./OrderService
    ports:
      - "8082:8080"
    environment:
      - ConnectionStrings__DefaultConnection=Server=sqlserver;Database=Orders;User Id=sa;Password=YourPassword123;TrustServerCertificate=True
    depends_on:
      - sqlserver

  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      SA_PASSWORD: "YourPassword123"
      ACCEPT_EULA: "Y"
```

### Full Stack Application

```yaml
version: "3.8"
services:
  frontend:
    build: ./BlazorApp
    ports:
      - "8080:8080"
    depends_on:
      - backend

  backend:
    build: ./WebApi
    ports:
      - "8081:8080"
    environment:
      - ConnectionStrings__DefaultConnection=Server=sqlserver;Database=MyApp;User Id=sa;Password=YourPassword123;TrustServerCertificate=True
    depends_on:
      - sqlserver
      - redis

  worker:
    build: ./WorkerService
    depends_on:
      - sqlserver
      - redis

  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      SA_PASSWORD: "YourPassword123"
      ACCEPT_EULA: "Y"

  redis:
    image: redis:alpine
```

## Production Optimizations

### Multi-stage with Runtime Optimization

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out --no-restore --runtime linux-x64 --self-contained false

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
RUN addgroup -g 1000 appuser && adduser -D -u 1000 -G appuser appuser
WORKDIR /app
COPY --from=build /app/out .
RUN chown -R appuser:appuser /app
USER appuser
EXPOSE 8080
CMD ["dotnet", "WebApi.dll"]
```

### Self-contained Deployment

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out --runtime linux-x64 --self-contained true /p:PublishTrimmed=true

FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-alpine
RUN addgroup -g 1000 appuser && adduser -D -u 1000 -G appuser appuser
WORKDIR /app
COPY --from=build /app/out .
RUN chown -R appuser:appuser /app
USER appuser
EXPOSE 8080
CMD ["./WebApi"]
```

### .dockerignore

```
**/bin/
**/obj/
**/.vs/
**/.vscode/
**/node_modules/
**/.git/
**/.gitignore
**/README.md
**/Dockerfile*
**/.dockerignore
**/docker-compose*
**/*.Development.json
```

### Health Check

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1
CMD ["dotnet", "WebApi.dll"]
```

Tất cả các project .NET/C# trên đều có thể build và chạy với Docker. Mỗi project đại diện cho một pattern phổ biến trong .NET development, từ web applications đến microservices và cross-platform mobile apps.
