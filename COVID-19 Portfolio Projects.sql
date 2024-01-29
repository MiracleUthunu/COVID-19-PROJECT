Select *
From Portfolio..CovidDeathsss
where continent is not null
Order by 3, 4

--Select *
--From Portfolio..CovidVaccinationnn
--Order by 3, 4

Select Location, date, population, total_cases, total_deaths, new_cases
From Portfolio..CovidDeathsss
Order by 1,2


---Population of people that got Covid
Select Location, date, population,total_cases,(total_cases/population)*100 as DeathPercentage
From Portfolio..CovidDeathsss
Where location like '%Africa%'
Order by 1,2



---Highest Infection Rate 
Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulationInfected
From Portfolio..CovidDeathsss
Group by Location, population
Order by PercentagePopulationInfected desc


---Countries with Highest Death Count per Population
Select Location, population, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portfolio..CovidDeathsss
Where continent is not null
Group by Location, population
Order by TotalDeathCount desc

--Continents with the Highest Death Count per Population  
Select continent, population, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portfolio..CovidDeathsss
where continent is not null
Group by continent, population
Order by TotalDeathCount desc


-- GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Portfolio..CovidDeathsss
Where continent is not null
--Group by date
Order by 1, 2



--- Total number of Population that have been vaccinated (Total Population vs Vaccination)

Select *
From Portfolio..CovidDeathsss dea
Join Portfolio..CovidVaccinationnn vacc
   on dea.location = vacc.location 
   and dea.date = vacc.date


Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations,
SUM(cast(new_vaccinations as numeric)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Portfolio..CovidDeathsss dea
Join Portfolio..CovidVaccinationnn vacc
   on dea.location = vacc.location 
   and dea.date = vacc.date
Where dea.continent is not null
Order by 2,3


---CTE

With PopvsVacc (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) as 
(Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations,
SUM(cast(new_vaccinations as numeric)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Portfolio..CovidDeathsss dea
Join Portfolio..CovidVaccinationnn vacc
   on dea.location = vacc.location 
   and dea.date = vacc.date
Where dea.continent is not null
--Order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVacc

--TEMP 

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccination numeric, 
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations,
SUM(Cast(new_vaccinations as numeric)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Portfolio..CovidDeathsss dea
Join Portfolio..CovidVaccinationnn vacc
   on dea.location = vacc.location 
   and dea.date = vacc.date
Where dea.continent is not null
--Order by 2,3

Select *, (RollingPeopleVaccinated)*100
From #PercentPopulationVaccinated

--Creating View to store data

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations,
SUM(convert(int, new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Portfolio..CovidDeathsss dea
Join Portfolio..CovidVaccinationnn vacc
   on dea.location = vacc.location 
   and dea.date = vacc.date
Where dea.continent is not null
--Order by 2,3


Create View Global_Numbers as
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Portfolio..CovidDeathsss
Where continent is not null
--Group by date
--Order by 1, 2

Create View HighestDeathCount as 
Select Location, population, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portfolio..CovidDeathsss
Where continent is not null
Group by Location, population
--Order by TotalDeathCount desc


