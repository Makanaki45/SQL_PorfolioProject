select * 
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4


select location, date, total_cases, new_cases, total_deaths, population 
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

-- Looking at Total Cases Vs Total Deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%state%'
and  continent is not null
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got covid

select location,date,population,total_cases,(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
where location like '%state%'
order by 1,2

-- Looking at Countries with Highest Infection Rate Compared to Population

select location, population, MAX(total_cases) AS HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
Group by location, population
order by PercentPopulationInfected desc

-- Showing Countries With Highest Death Count Per Population

select location, MAX(cast(total_deaths as int)) AS TotalDeathsCount
from PortfolioProject..CovidDeaths
where continent is not null
Group by location
order by TotalDeathsCount desc

-- Showing Continent With the Highest Death Count Per Population

select continent, MAX(cast(total_deaths as int)) AS TotalDeathsCount
from PortfolioProject..CovidDeaths
where continent is not null
Group by continent
order by TotalDeathsCount desc

-- Global Numbers

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(
new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2


-- Looking at Total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) OVER (partition by dea.location)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by  2, 3
