SELECT *
  FROM COVID
  ORDER BY 2,3

--SELECT *
--  FROM COVIDNEW
--  ORDER BY 2,3

--SELECT location, total_cases, new_cases, total_deaths, population
--  FROM COVID
--  ORDER BY 1,4
  
--Looking at total cases versus total population
SELECT location, date, total_cases, total_deaths, (total_cases/population)*100 AS Death_Rate
  FROM COVID
  WHERE location LIKE '%states%'
  ORDER BY 1

ALTER TABLE COVID
ALTER COLUMN total_deaths int

--Looking at total cases versus total_deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Rate
  FROM COVID
  WHERE location LIKE '%states%'
  ORDER BY 1

  --Looking for highest infection rate against their population

  SELECT CONTINENT, Max(total_cases) AS HighestInfectionCount, Max((total_cases/population))*100 AS Death_Percentage
  FROM COVID
  --WHERE location LIKE '%states%'
  WHERE CONTINENT IS NOT NULL
  GROUP BY continent
  ORDER BY Death_Percentage DESC

  --SHOWING CONTINENT WITH THE HIGHEST DEATH COUNT PER POPULATION
  SELECT DATE,CONTINENT, MAX(TOTAL_DEATHS) AS HIGHESTDEATHCOUNT
  FROM COVID
  WHERE CONTINENT IS NOT NULL
  GROUP BY DATE,CONTINENT
  ORDER BY DATE DESC

   --LOOKING AT TOTAL POPULATION VS VACCINATION
  SELECT COVID.CONTINENT,COVID.LOCATION,COVID.DATE,COVID.POPULATION,COVIDNEW.new_vaccinations,SUM(CONVERT(INT,COVIDNEW.NEW_VACCINATIONS))
  OVER (PARTITION BY COVID.LOCATION ORDER BY COVID.LOCATION,COVID.DATE) AS ROLLINGPEOPLEVACCINATED
  FROM COVID 
  JOIN COVIDNEW 
  ON COVID.LOCATION = COVIDNEW.LOCATION
  AND COVID.DATE = COVIDNEW.DATE
  WHERE.COVID.CONTINENT IS NOT NULL
  ORDER BY 1,2

  --CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION
