# ==========================================
# 階段 1: 構建與發布 (Build / Publish)
# ==========================================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# 1. 複製專案檔並還原依賴項 (善用 Docker Layer Cache)
COPY ["MyApp.csproj", "./"]
RUN dotnet restore "MyApp.csproj"

# 2. 複製剩餘原始碼並進行編譯發布
COPY . .
RUN dotnet publish "MyApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# ==========================================
# 階段 2: 運行環境 (Runtime)
# ==========================================
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

# 複製發布後的二進位檔案
COPY --from=build /app/publish .

# .NET 8/9/10 預設使用 non-root 使用者 (app, UID 1654)
USER $APP_UID

# 預設監聽 Port 8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "MyApp.dll"]
