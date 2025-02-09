#OPTION('obfuscateOutput', TRUE);
IMPORT $;
IMPORT std;
MSDMusic := $.File_Music.MSDDS;

//display the first 150 records
OUTPUT(CHOOSEN(MSDMusic, 150), NAMED('Raw_MusicDS'));

//*********************************************************************************
//*********************************************************************************

//                                CATEGORY ONE 

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Reverse Sort by "year" and count your total music dataset and display the first 50

//Result: Total count is 1000000
msd_count := COUNT(MSDMusic);
OUTPUT(msd_count, NAMED('Total_MSDMusic_Count'));
//Reverse sort by "year"
reverse_msd := SORT(MSDMusic, -year);
first_50 := CHOOSEN(reverse_msd, 50);

//display the first 50


//Count and display result
OUTPUT(first_50, NAMED('Reverse_Sorted_Music'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Display first 50 songs by of year 2010 and then count the total


first_50_count := COUNT(MSDMusic(year = 2010));
//Result should have 9397 songs for 2010

//Filter for 2010 and display the first 50
first_50_2010 := CHOOSEN(MSDMusic(year = 2010), 50);
//Count total songs released in 2010:
OUTPUT(first_50_2010, NAMED('First_50_2010'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Count how many songs was produced by "Prince" in 1982

//Result should have 4 counts
prince_songs_count := COUNT(MSDMusic(artist_name = 'Prince' AND year = 1982));

//Filter ds for "Prince" AND 1982
prince_filter := MSDMusic(artist_name = 'Prince' AND year = 1982);
//Count and print total 
prince_count := COUNT(prince_filter);
OUTPUT(prince_songs_count, NAMED('Prince_Songs_Count'));
//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Who sang "Into Temptation"?

// Result should have 3 records

//Filter for "Into Temptation"
into_temptation_filter := MSDMusic(STD.Str.ToUpperCase(title) = STD.Str.ToUpperCase('Into Temptation'));

//Display result 
OUTPUT(into_temptation_filter, NAMED('Into_Temptation'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Sort songs by Artist and song title, output the first 100

//Result: The first 10 records have no artist name, followed by "- PlusMinus"                                     

//Sort dataset by Artist, and Title
artist_song_sort := SORT(MSDMusic, artist_name, title);

//Output the first 100
first_100 := CHOOSEN(artist_song_sort, 100);
OUTPUT(first_100, NAMED('First_100_Artist_Song'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//What is the hottest song by year in the Million Song Dataset?
//Sort Result by Year (filter iut zero Year values)

//Result is 

//Filter dataset for the maxHot value
maxHot_filter := MSDMusic(song_hotness > 0 and year > 0);
//Get the datasets maximum hotness value
HotnessYearLayout := RECORD
    MSDMusic.year;
    maxHot := MAX(GROUP, MSDMusic.song_hotness);
    MSDMusic.title;
END;

hotness_year_table := TABLE(maxHot_filter, HotnessYearLayout, year);
hotness_year_table_sorted := SORT(hotness_year_table, -year);
hottest_song := CHOOSEN(hotness_year_table_sorted, 1);
OUTPUT(hotness_year_table_sorted, NAMED('MaxHot_Year'));

//Display the result
OUTPUT(hottest_song, NAMED('Hottest_Song_Year'));


/*valid_year_songs := MSDMusic(year > 0);

HotnessLayout := RECORD
    valid_year_songs.year;
    MaxHotness := MAX(GROUP, valid_year_songs.song_hotness);
END;


year_hotness := TABLE(valid_year_songs, HotnessLayout, year);


hottest_songs := JOIN(valid_year_songs, year_hotness, LEFT.year = RIGHT.year AND LEFT.song_hotness = RIGHT.MaxHotness);


sorted_hottest_songs := SORT(hottest_songs, year);
hottest_song := CHOOSEN(sorted_hottest_songs, 1);
OUTPUT(hottest_song, NAMED('Hottest_Song_Year'));
*/
//*********************************************************************************
//*********************************************************************************

//                                CATEGORY TWO

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Display all songs produced by the artist "Coldplay" AND has a 
//"Song Hotness" greater or equal to .75 ( >= .75 ) , SORT it by title.
//Count the total result

coldplay_filter := COUNT(MSDMusic(artist_name = 'Coldplay' AND song_hotness >= .75));

//Result has 47 records

//Get songs by defined conditions
coldplay_tracks := MSDMusic(artist_name = 'Coldplay' AND song_hotness >= .75);

//Sort the result
sort_coldplay := SORT(coldplay_tracks, title);

//Output the result
OUTPUT(sort_coldplay, NAMED('Coldplay_Tracks'));

//Count and output result 
OUTPUT(coldplay_filter, NAMED('Coldplay_Tracks_Count'));


//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Count all songs where "Duration" is between 200 AND 250 (inclusive) 
//AND "song_hotness" is not equal to 0 
//AND familarity > .9

//Result is 762 songs  

//Hint: (SongDuration BETWEEN 200 AND 250)

//Filter for required conditions
duration_filter := MSDMusic(duration >= 200 AND duration <= 250 AND song_hotness <> 0 AND familiarity > .9);
//Count result
duration_count := COUNT(duration_filter);                

//Display result
OUTPUT(duration_count, NAMED('Duration_Count'));

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Create a new dataset which only has  "Title", "Artist_Name", "Release_Name" and "Year"
//Display the first 50

//Result should only have 4 columns. 

//Hint: Create your new RECORD layout and use TRANSFORM for new fields. 
//Use PROJECT, to loop through your music dataset
First50Layout := RECORD
    STRING title;
    STRING artist_name;
    STRING release_name;
    UNSIGNED4 year;
END;

//Standalone Transform 
first50_dataset := PROJECT(MSDMusic, 
TRANSFORM(First50Layout, 
    SELF.title := LEFT.title,
    SELF.artist_name := LEFT.artist_name,
    SELF.release_name := LEFT.release_name,
    SELF.year := LEFT.year
));

//PROJECT

// Display result  
OUTPUT(CHOOSEN(first50_dataset, 50), NAMED('Title_Artist_Release_Year'));
//*********************************************************************************
//*********************************************************************************

//Challenge: 
//1- What’s the correlation between "song_hotness" AND "artist_hotness"
//2- What’s the correlation between "barsstartdev" AND "beatsstartdev"

//Result for hotness = 0.4706972681953097, StartDev = 0.8896342348554744

hotness_filter := MSDMusic(song_hotness <> 0 AND artist_hotness <> 0);
beat_filter := MSDMusic(barsstartdev <> 0 AND beatsstartdev <> 0);
correlation_hotness := CORRELATION(hotness_filter, song_hotness, artist_hotness);
correlation_beat := CORRELATION(beat_filter, barsstartdev, beatsstartdev);

OUTPUT(correlation_hotness, NAMED('Correlation_Hotness'));
OUTPUT(correlation_beat, NAMED('Correlation_Beat'));

//*********************************************************************************
//*********************************************************************************

//                                CATEGORY THREE

//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Create a new dataset which only has following conditions
//   *  Column named "Song" that has "Title" values 
//   *  Column named "Artist" that has "artist_name" values 
//   *  New BOOLEAN Column called isPopular, and it's TRUE is IF "song_hotness" is greater than .80
//   *  New BOOLEAN Column called "IsTooLoud" which is TRUE IF "Loudness" > 0
//Display the first 50

//Result should have 4 columns named "Song", "Artist", "isPopular", and "IsTooLoud"


//Hint: Create your new layout and use TRANSFORM for new fields. 
//      Use PROJECT, to loop through your music dataset

//Create the RECORD layout
NewLayout := RECORD
    STRING song;
    STRING artist;
    BOOLEAN isPopular;
    BOOLEAN isTooLoud;
END;

//Build your TRANSFORM
new_dataset := PROJECT(MSDMusic,
TRANSFORM(NewLayout,
    SELF.song := LEFT.title,
    SELF.artist := LEFT.artist_name,
    SELF.isPopular := LEFT.song_hotness > .80,
    SELF.isTooLoud := LEFT.loudness > 0
));

//Creating the PROJECT


//Display the result
OUTPUT(new_dataset, NAMED('Song_Artist_Popular_Loud'));
                       
                                              
//*********************************************************************************
//*********************************************************************************
//Challenge: 
//Display number of songs per "Year" and count your total 

//Result has 2 col, Year and TotalSongs, count is 89

//Hint: All you need is a cross-tab TABLE 
YearSongCount_Layout := RECORD
    MSDMusic.year;                  
    TotalSongs := COUNT(GROUP);      
END;
//Display the  result      
year_song_table := TABLE(MSDMusic, YearSongCount_Layout, year);

//Count and display total number of years counted
year_song_count := COUNT(year_song_table);
OUTPUT(year_song_table, NAMED('Year_Song_Table'));
OUTPUT(year_song_count, NAMED('Year_Song_Count'));


//*********************************************************************************
//*********************************************************************************
// What Artist had the overall hottest songs between 2006-2007?
// Calculate average "song_hotness" per "Artist_name" for "Year" 2006 and 2007

// Hint: All you need is a TABLE, and see the TOPN function for your OUTPUT 

// Filter for year
songs_06_07 := MSDMusic(year >= 2006 AND year <= 2007);
// Output the top ten results showing two columns, Artist_Name, and HotRate.
Artist_HotRate_Layout := RECORD
    songs_06_07.artist_name;
    HotRate := AVE(GROUP, songs_06_07.song_hotness);
END;

// Create a Cross-Tab TABLE:
artist_hotness_table := TABLE(songs_06_07, Artist_HotRate_Layout, artist_name);


// Display the top ten results with top "HotRate"      
top_10 := TOPN(artist_hotness_table, 10, -HotRate);
OUTPUT(top_10, NAMED('Top_Artist_Hotness'));
