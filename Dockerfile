# Use the official .NET image as a base
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Use the SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Adjust the path if your .csproj is in a different location
COPY ["UserManagerApp/UserManagerApp.csproj", "/src/UserManagerApp/"]
RUN dotnet restore "/src/UserManagerApp/UserManagerApp.csproj"

COPY . .
WORKDIR "/src/UserManagerApp"
RUN dotnet build "UserManagerApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "UserManagerApp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "UserManagerApp.dll"]
