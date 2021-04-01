INSERT INTO Participant(OutID, Birth, SextypeName, RegName, AreaName, TerName, RegTypeName, terTypeName, ClassProfileName, ClassLangName)
SELECT OutID, Birth, SextypeName, RegName, AreaName, TerName, RegTypeName, TerTypeName, ClassProfileName, ClassLangName
FROM eng_results;


INSERT INTO Place(PlaceName, PlaceTypeName, PlaceRegName, PlaceAreaName, PlaceTerName, PlaceParent)
SELECT DISTINCT TRIM(EOName) as PlaceName,
                TRIM(EOTypeName) as PlaceTypeName,
                TRIM(EORegName) as PlaceRegName,
                TRIM(EOAreaName) as PlaceAreaName,
                TRIM(EOTerName) as PlaceTerName,
                TRIM(EOParent) as PlaceParent
FROM eng_results FULL OUTER JOIN
(
    SELECT DISTINCT *
    FROM 
    (
        SELECT TRIM(ukrPTName) as PlaceName,
               TRIM(ukrPTRegName) as PlaceRegName,
               TRIM(ukrPTAreaName) as PlaceAreaName,
               TRIM(ukrPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(histPTName) as PlaceName,
               TRIM(histPTRegName) as PlaceRegName,
               TRIM(histPTAreaName) as PlaceAreaName,
               TRIM(histPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(mathPTName) as PlaceName,
               TRIM(mathPTRegName) as PlaceRegName,
               TRIM(mathPTAreaName) as PlaceAreaName,
               TRIM(mathPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(physPTName) as PlaceName,
               TRIM(physPTRegName) as PlaceRegName,
               TRIM(physPTAreaName) as PlaceAreaName,
               TRIM(physPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(chemPTName) as PlaceName,
               TRIM(chemPTRegName) as PlaceRegName,
               TRIM(chemPTAreaName) as PlaceAreaName,
               TRIM(chemPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(bioPTName) as PlaceName,
               TRIM(bioPTRegName) as PlaceRegName,
               TRIM(bioPTAreaName) as PlaceAreaName,
               TRIM(bioPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(geoPTName) as PlaceName,
               TRIM(geoPTRegName) as PlaceRegName,
               TRIM(geoPTAreaName) as PlaceAreaName,
               TRIM(geoPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(engPTName) as PlaceName,
               TRIM(engPTRegName) as PlaceRegName,
               TRIM(engPTAreaName) as PlaceAreaName,
               TRIM(engPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(frPTName) as PlaceName,
               TRIM(frPTRegName) as PlaceRegName,
               TRIM(frPTAreaName) as PlaceAreaName,
               TRIM(frPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(deuPTName) as PlaceName,
               TRIM(deuPTRegName) as PlaceRegName,
               TRIM(deuPTAreaName) as PlaceAreaName,
               TRIM(deuPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(spPTName) as PlaceName,
               TRIM(spPTRegName) as PlaceRegName,
               TRIM(spPTAreaName) as PlaceAreaName,
               TRIM(spPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(rusPTName) as PlaceName,
               TRIM(rusPTRegName) as PlaceRegName,
               TRIM(rusPTAreaName) as PlaceAreaName,
               TRIM(rusPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(fraPTName) as PlaceName,
               TRIM(fraPTRegName) as PlaceRegName,
               TRIM(fraPTAreaName) as PlaceAreaName,
               TRIM(fraPTTerName) as PlaceTerName
        FROM eng_results
        UNION
        SELECT TRIM(spaPTName) as PlaceName,
               TRIM(spaPTRegName) as PlaceRegName,
               TRIM(spaPTAreaName) as PlaceAreaName,
               TRIM(spaPTTerName) as PlaceTerName
        FROM eng_results

    ) AS big_union
) AS TMP
ON  TRIM(eng_results.EOName)     = TMP.PlaceName
AND TRIM(eng_results.EORegName)  = TMP.PlaceRegName
AND TRIM(eng_results.EOAreaName) = TMP.PlaceAreaName
AND TRIM(eng_results.EOTerName)  = TMP.PlaceTerName;


INSERT INTO Subjects (SubjectID, Description)
VALUES 
    ('Ukr', 'Українська мова і література'),
    ('Hist', 'Історія України'),
    ('Math', 'Математика'),
    ('Phys', 'Фізика'),
    ('Chem', 'Хімія'),
    ('Bio', 'Біологія'),
    ('Geo', 'Географія'),
    ('Eng', 'Англійська мова'),
    ('Deu', 'Німецька мова'),
    ('Spa', 'Іспанська мова'),
    ('Fra', 'Французька мова'),
    ('Rus', 'Російська мова');


INSERT INTO ParticipantStudyPlace (OutID, PlaceID)
SELECT OutID, PlaceID
FROM eng_results INNER JOIN Place
ON  TRIM(eng_results.EOName)     = Place.PlaceName
AND TRIM(eng_results.EORegName)  = Place.PlaceRegName
AND TRIM(eng_results.EOAreaName) = Place.PlaceAreaName
AND TRIM(eng_results.EOTerName)  = Place.PlaceTerName;


INSERT INTO ParticipantZNOPlace (OutID, PlaceID, SubjectID)
SELECT OutID, PlaceID, SubjectID
FROM
(   
    SELECT * FROM
    (SELECT OutID, 
           TRIM(ukrTest) as Test,
           TRIM(ukrPTName) as PlaceName,
           TRIM(ukrPTRegName) as PlaceRegName,
           TRIM(ukrPTAreaName) as PlaceAreaName,
           TRIM(ukrPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,
           TRIM(histTest) as Test,
           TRIM(histPTName) as PlaceName,
           TRIM(histPTRegName) as PlaceRegName,
           TRIM(histPTAreaName) as PlaceAreaName,
           TRIM(histPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID, 
           TRIM(mathTest) as Test,
           TRIM(mathPTName) as PlaceName,
           TRIM(mathPTRegName) as PlaceRegName,
           TRIM(mathPTAreaName) as PlaceAreaName,
           TRIM(mathPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID, 
           TRIM(physTest) as Test,
           TRIM(physPTName) as PlaceName,
           TRIM(physPTRegName) as PlaceRegName,
           TRIM(physPTAreaName) as PlaceAreaName,
           TRIM(physPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID, 
           TRIM(chemTest) as Test,
           TRIM(chemPTName) as PlaceName,
           TRIM(chemPTRegName) as PlaceRegName,
           TRIM(chemPTAreaName) as PlaceAreaName,
           TRIM(chemPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID, 
           TRIM(bioTest) as Test,
           TRIM(bioPTName) as PlaceName,
           TRIM(bioPTRegName) as PlaceRegName,
           TRIM(bioPTAreaName) as PlaceAreaName,
           TRIM(bioPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID, 
           TRIM(geoTest) as Test,
           TRIM(geoPTName) as PlaceName,
           TRIM(geoPTRegName) as PlaceRegName,
           TRIM(geoPTAreaName) as PlaceAreaName,
           TRIM(geoPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(engTest) as Test,
           TRIM(engPTName) as PlaceName,
           TRIM(engPTRegName) as PlaceRegName,
           TRIM(engPTAreaName) as PlaceAreaName,
           TRIM(engPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(frTest) as Test,
           TRIM(frPTName) as PlaceName,
           TRIM(frPTRegName) as PlaceRegName,
           TRIM(frPTAreaName) as PlaceAreaName,
           TRIM(frPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(deuTest) as Test,
           TRIM(deuPTName) as PlaceName,
           TRIM(deuPTRegName) as PlaceRegName,
           TRIM(deuPTAreaName) as PlaceAreaName,
           TRIM(deuPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(spTest) as Test,
           TRIM(spPTName) as PlaceName,
           TRIM(spPTRegName) as PlaceRegName,
           TRIM(spPTAreaName) as PlaceAreaName,
           TRIM(spPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(rusTest) as Test,
           TRIM(rusPTName) as PlaceName,
           TRIM(rusPTRegName) as PlaceRegName,
           TRIM(rusPTAreaName) as PlaceAreaName,
           TRIM(rusPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(fraTest) as Test,
           TRIM(fraPTName) as PlaceName,
           TRIM(fraPTRegName) as PlaceRegName,
           TRIM(fraPTAreaName) as PlaceAreaName,
           TRIM(fraPTTerName) as PlaceTerName
    FROM eng_results
    UNION
    SELECT OutID,  
           TRIM(spaTest) as Test,
           TRIM(spaPTName) as PlaceName,
           TRIM(spaPTRegName) as PlaceRegName,
           TRIM(spaPTAreaName) as PlaceAreaName,
           TRIM(spaPTTerName) as PlaceTerName
    FROM eng_results) as big_union INNER JOIN Subjects ON TRIM(big_union.Test) = Subjects.Description
) AS tmp INNER JOIN Place
ON  tmp.PlaceName     = Place.PlaceName
AND tmp.PlaceRegName  = Place.PlaceRegName
AND tmp.PlaceAreaName = Place.PlaceAreaName
AND tmp.PlaceTerName  = Place.PlaceTerName;

INSERT INTO Results (OutId, SubjectID, Lang, TestStatus, DPALevel, Ball100, Ball12, Ball, AdaptScale, Year)
SELECT OutId, SubjectID, Lang, TestStatus, DPALevel, Ball100, Ball12, Ball, AdaptScale, Year
FROM
(
    SELECT OutID,
           ukrTest       as Test,
           NULL          as Lang,
           ukrTestStatus as TestStatus,
           NULL          as DPALevel,
           ukrBall100    as Ball100,
           ukrBall12     as Ball12,
           ukrBall       as Ball,
           ukrAdaptScale as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           histTest       as Test,
           histLang       as Lang,
           histTestStatus as TestStatus,
           NULL           as DPALevel,
           histBall100    as Ball100,
           histBall12     as Ball12,
           histBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           mathTest       as Test,
           mathLang       as Lang,
           mathTestStatus as TestStatus,
           NULL           as DPALevel,
           mathBall100    as Ball100,
           mathBall12     as Ball12,
           mathBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           physTest       as Test,
           physLang       as Lang,
           physTestStatus as TestStatus,
           NULL           as DPALevel,
           physBall100    as Ball100,
           physBall12     as Ball12,
           physBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           chemTest       as Test,
           chemLang       as Lang,
           chemTestStatus as TestStatus,
           NULL           as DPALevel,
           chemBall100    as Ball100,
           chemBall12     as Ball12,
           chemBall       as Ball,
           NULL           as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           bioTest       as Test,
           bioLang       as Lang,
           bioTestStatus as TestStatus,
           NULL          as DPALevel,
           bioBall100    as Ball100,
           bioBall12     as Ball12,
           bioBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           geoTest       as Test,
           geoLang       as Lang,
           geoTestStatus as TestStatus,
           NULL          as DPALevel,
           geoBall100    as Ball100,
           geoBall12     as Ball12,
           geoBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           engTest       as Test,
           NULL          as Lang,
           engTestStatus as TestStatus,
           engDPALevel   as DPALevel,
           engBall100    as Ball100,
           engBall12     as Ball12,
           engBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           frTest       as Test,
           NULL         as Lang,
           frTestStatus as TestStatus,
           NULL         as DPALevel,
           frBall100    as Ball100,
           NULL         as Ball12,
           NULL         as Ball,
           NULL         as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           fraTest       as Test,
           NULL          as Lang,
           fraTestStatus as TestStatus,
           fraDPALevel   as DPALevel,
           fraBall100    as Ball100,
           fraBall12     as Ball12,
           fraBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           deuTest       as Test,
           NULL          as Lang,
           deuTestStatus as TestStatus,
           deuDPALevel   as DPALevel,
           deuBall100    as Ball100,
           deuBall12     as Ball12,
           deuBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           spaTest       as Test,
           NULL          as Lang,
           spaTestStatus as TestStatus,
           spaDPALevel   as DPALevel,
           spaBall100    as Ball100,
           spaBall12     as Ball12,
           spaBall       as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           spTest       as Test,
           NULL         as Lang,
           spTestStatus as TestStatus,
           NULL         as DPALevel,
           spBall100    as Ball100,
           NULL         as Ball12,
           NULL         as Ball,
           NULL         as AdaptScale,
           Year
    FROM eng_results
    UNION
    SELECT OutID,
           rusTest       as Test,
           NULL          as Lang,
           rusTestStatus as TestStatus,
           NULL          as DPALevel,
           rusBall100    as Ball100,
           rusBall12     as Ball12,
           NULL          as Ball,
           NULL          as AdaptScale,
           Year
    FROM eng_results
) as tmp INNER JOIN Subjects
ON TRIM(tmp.Test) = Subjects.Description;