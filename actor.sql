-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962
 

-- Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- Obtain the cast list for the film 'Alien'
SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
JOIN movie
ON movie.id = casting.movieid
WHERE movie.title = 'Alien';

-- List the films in which 'Harrison Ford' has appeared
SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. 
SELECT movie.title
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'
AND casting.ord != 1;

-- List the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name
FROM movie
JOIN casting
ON casting.movieid = movie.id
JOIN actor
ON actor.id = casting.actorid
WHERE movie.yr = 1962
AND casting.ord = 1;

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
   FROM movie JOIN casting ON (movieid=movie.id AND ord=1)
               JOIN actor ON (actorid=actor.id)
WHERE movie.id IN (SELECT movieid FROM casting
WHERE actorid IN (SELECT id FROM actor
WHERE name = 'Julie Andrews'))

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT actor.name
FROM actor
JOIN casting
ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 30;

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title
SELECT title, COUNT(actorid) AS actors FROM movie
JOIN casting ON id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY actors DESC, title


-- List all the people who have worked with 'Art Garfunkel'.
SELECT a.name
  FROM (SELECT movie.*
          FROM movie
          JOIN casting
            ON casting.movieid = movie.id
          JOIN actor
            ON actor.id = casting.actorid
         WHERE actor.name = 'Art Garfunkel') AS m
  JOIN (SELECT actor.*, casting.movieid
          FROM actor
          JOIN casting
            ON casting.actorid = actor.id
         WHERE actor.name != 'Art Garfunkel') as a
    ON m.id = a.movieid;






