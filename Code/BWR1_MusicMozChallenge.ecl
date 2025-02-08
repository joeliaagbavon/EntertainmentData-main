#OPTION('obfuscateOutput', TRUE);
IMPORT $;
MozMusic := $.File_Music.MozDS;

//display the first 150 records

OUTPUT(CHOOSEN(MozMusic, 150), NAMED('Moz_MusicDS'));

//*********************************************************************************
//*********************************************************************************

//                                CATEGORY ONE 

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Count all the records in the dataset:

COUNT(MozMusic);

//Result: Total count is 136510

//*********************************************************************************
//*********************************************************************************
//Challenge: 

//Sort by "name",  and display (OUTPUT) the first 50(Hint: use CHOOSEN):

//You should see a lot of songs by NSync 
SortedName := SORT(MozMusic, name);
OUTPUT(CHOOSEN(SortedName, 50), NAMED('SortedName'));


//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Count total songs in the "Rock" genre and display number:

COUNT(MOZMUSIC(genre='Rock'));

//Result should have 12821 Rock songs

//Display your Rock songs (OUTPUT):
OUTPUT(MOZMUSIC(genre='Rock'), NAMED('Rock_Music'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Count how many songs was released by Depeche Mode between 1980 and 1989

//Filter ds for "Depeche_Mode" AND releasedate BETWEEN 1980 and 1989


  //filtered_dm := MOZMUSIC(INTEGER(releasedate) >= 1980 AND INTEGER(releasedate) <= 1989);
// Count and display total
filtered_depeche := MozMusic(name ='Depeche_Mode' AND releasedate  BETWEEN '1980' AND '1989');
depeche_count := COUNT(filtered_depeche);
OUTPUT(depeche_count, NAMED('Depeche_Count'));

//Result should have 127 songs 


//Bonus points: filter out duplicate tracks (Hint: look at DEDUP):
filter_dup := DEDUP(filtered_depeche, tracktitle);
dedup_count := COUNT(filter_dup);
OUTPUT(dedup_count, NAMED('Depeche_Dedup_Count'));
OUTPUT(filter_dup, NAMED('Depeche_Dedup'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Who sang the song "My Way"?

//Filter for "My Way" tracktitle
filter_myway := MozMusic(tracktitle= 'My Way');
count_myway := COUNT(filter_myway);
// Result should have 136 records 

//Display count and result 
OUTPUT(filter_myway, NAMED('MyWay_List'));
OUTPUT(count_myway, NAMED('MyWay_Count'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//What song(s) in the Music Moz Dataset has the longest track title in CD format?

//Get the longest description (tracktitle) field length in CD "formats"
filter_cd := MozMusic(formats='CD');
OUTPUT(filter_cd, NAMED('CD_Tracks'));
//Filter dataset for tracktitle with the longest value
longest_desc_length := MAX(filter_cd, LENGTH(tracktitle));
OUTPUT(longest_desc_length, NAMED('Longest_Track_Title_Length'));
longest_desc_tracks := filter_cd(LENGTH(tracktitle) = longest_desc_length);
OUTPUT(longest_desc_tracks, NAMED('Longest_Track_Title')); 
//Display the result

//Longest track title is by the "The Brand New Heavies"               


//*********************************************************************************
//*********************************************************************************

//                                CATEGORY TWO

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Display all songs produced by "U2" , SORT it by title.

//Filter track by artist


//Sort the result by tracktitle


//Output the result


//Count result 


//Result has 190 records


//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Count all songs where guest musicians appeared 

//Hint: Think of the filter as "not blank" 

//Filter for "guestmusicians"


//Display Count result
                             

//Result should be 44588 songs  


//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Create a new recordset which only has "Track", "Release", "Artist", and "Year"
// Get the "track" value from the MusicMoz TrackTitle field
// Get the "release" value from the MusicMoz Title field
// Get the "artist" value from the MusicMoz Name field
// Get the "year" value from the MusicMoz ReleaseDate field

//Result should only have 4 fields. 

//Hint: First create your new RECORD layout  



//Next: Standalone Transform - use TRANSFORM for new fields.


//Use PROJECT, to loop through your music dataset


// Display result  
      

//*********************************************************************************
//*********************************************************************************

//                                CATEGORY THREE

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Display number of songs per "Genre", display genre name and count for each 

//Hint: All you need is a 2 field TABLE using cross-tab

//Display the TABLE result      


//Count and display total records in TABLE


//Result has 2 fields, Genre and TotalSongs, count is 1000

//*********************************************************************************
//*********************************************************************************
//What Artist had the most releases between 2001-2010 (releasedate)?

//Hint: All you need is a cross-tab TABLE 

//Output Name, and Title Count(TitleCnt)

//Filter for year (releasedate)

//Cross-tab TABLE


//Display the result      
