# FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS base
# WORKDIR /app
# ENV ASPNETCORE_URLS http://+:5000;https://+:5001
# EXPOSE 5000
# EXPOSE 5001
# copy csproj and restore as distinct layers
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS build
WORKDIR /TestApi
COPY ["*.csproj", "./"]
RUN dotnet restore "./TestApi.csproj"
COPY . .

# copy everything else and build app
COPY TestApi/. ./TestApi/
WORKDIR /app/TestApi
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/TestApi/out ./
ENTRYPOINT ["dotnet", "TestApi.dll"]