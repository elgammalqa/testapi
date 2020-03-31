FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY TestApi/*.csproj ./TestApi/
RUN dotnet restore

# copy everything else and build app
COPY TestApi/. ./TestApi/
WORKDIR /app/TestApi
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/TestApi/out ./
ENTRYPOINT ["dotnet", "TestApi.dll"]