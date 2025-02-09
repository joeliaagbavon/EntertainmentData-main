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
max_desc_length := MAX(filter_cd, LENGTH(tracktitle));
longest_tracktitle := filter_cd(LENGTH(tracktitle) = max_desc_length);  
OUTPUT(max_desc_length, NAMED('Max_Track_Title_Length')); 
OUTPUT(longest_tracktitle, NAMED('Longest_Track_Title')); 

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
artist_filter := MozMusic(name = 'U2');

//Sort the result by tracktitle
sort_tracktitle := SORT(artist_filter, tracktitle);

//Output the result
OUTPUT(sort_tracktitle, NAMED('U2_Tracks'));

//Count result 
u2_tracks_count := COUNT(sort_tracktitle);

//Result has 190 records
OUTPUT(u2_tracks_count, NAMED('U2_Tracks_Count'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Count all songs where guest musicians appeared 

//Hint: Think of the filter as "not blank" 

//Filter for "guestmusicians"
guest_musicians := MozMusic(guestmusicians <> '');

//Display Count result
guest_musicians_count := COUNT(guest_musicians);                    

//Result should be 44588 songs  
OUTPUT(guest_musicians_count, NAMED('Guest_Musicians_Count'));

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
NewRecordLayout := RECORD 
 STRING track;
    STRING release;
    STRING artist;
    STRING year;
END;

//Next: Standalone Transform - use TRANSFORM for new fields.
transform_data := PROJECT(MozMusic, 
TRANSFORM(NewRecordLayout,
  SELF.track := LEFT.tracktitle,
  SELF.release := LEFT.title,
    SELF.artist := LEFT.name,
  SELF.year := LEFT.releasedate,
));



//Use PROJECT, to loop through your music dataset


// Display result  
OUTPUT(transform_data, NAMED('Track_Release_Artist_Year'));

//*********************************************************************************
//*********************************************************************************

//                                CATEGORY THREE

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Display number of songs per "Genre", display genre name and count for each 

//Hint: All you need is a 2 field TABLE using cross-tab

//Display the TABLE result      
GenreSongCount_Layout := RECORD
    MozMusic.genre;                  
    TotalSongs := COUNT(GROUP);      
END;

// Create a table that groups by Genre and counts the number of songs in each genre
genre_song_count := TABLE(MozMusic, GenreSongCount_Layout, genre);

// Output the result
OUTPUT(genre_song_count, NAMED('Genre_Song_Count'));

// Count the total number of records in the table
total_records := COUNT(genre_song_count);
OUTPUT(total_records, NAMED('Total_Records'));


//Count and display total records in TABLE


//Result has 2 fields, Genre and TotalSongs, count is 1000

//*********************************************************************************
//*********************************************************************************
//What Artist had the most releases between 2001-2010 (releasedate)?

//Hint: All you need is a cross-tab TABLE 
Artist_Popularity_Layout := RECORD
    MozMusic.name;                  
    TotalSongs := COUNT(GROUP);      
END;
release_filter := MozMusic(releasedate BETWEEN '2001' AND '2010');

artist_song_count := TABLE(MozMusic, Artist_Popularity_Layout, name);

//Output Name, and Title Count(TitleCnt)
OUTPUT(artist_song_count, NAMED('Artist_Song_Count'));
//Filter for year (releasedate)

//Cross-tab TABLE

//Display the result   
OUTPUT(release_filter, NAMED('Artist_Releases'));
