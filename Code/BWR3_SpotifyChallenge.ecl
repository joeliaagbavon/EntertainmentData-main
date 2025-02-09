#OPTION('obfuscateOutput', TRUE);
IMPORT $;
IMPORT std;
SpotMusic := $.File_Music.SpotDS;

//display the first 150 records

OUTPUT(CHOOSEN(SpotMusic, 150), NAMED('Raw_MusicDS'));


//*********************************************************************************
//*********************************************************************************

//                                CATEGORY ONE 

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Sort songs by genre and count the number of songs in your total music dataset 
 

//Sort by "genre" (See SORT function)
genre_sort := SORT(SpotMusic, genre);

//Display them: (See OUTPUT)
OUTPUT(genre_sort, NAMED('Sorted_Genre'));


//Count and display result (See COUNT)
//Result: Total count is 1159764:
total_count := COUNT(genre_sort);
OUTPUT(total_count, NAMED('Total_Songs_Count'));

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Display songs by "garage" genre and then count the total 
//Filter for garage genre and OUTPUT them:

//Count total garage songs
songs_by_garage := SpotMusic(genre = 'garage');
songs_by_garage_count := COUNT(songs_by_garage);
//Result should have 17123 records:
OUTPUT(songs_by_garage, NAMED('Garage_Songs'));
OUTPUT(songs_by_garage_count, NAMED('Garage_Songs_Count'));


//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Count how many songs was produced by "Prince" in 2001

//Filter ds for 'Prince' AND 2001
filter_prince := SpotMusic(artist_name = 'Prince' AND year = 2001);

//Count and output total - should be 35 
prince_count := COUNT(filter_prince);
OUTPUT(prince_count, NAMED('Prince_Songs_Count'));


//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Who sang "Temptation to Exist"?

// Result should have 1 record and the artist is "New York Dolls"

//Filter for "Temptation to Exist" (name is case sensitive)
filter_temptation := SpotMusic(STD.Str.ToUpperCase(track_name) = STD.Str.ToUpperCase('Temptation to Exist'));
//Display result 
OUTPUT(filter_temptation, NAMED('Temptation_Song'));

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Output songs sorted by Artist_name and track_name, respectively

//Result: First few rows should have Artist and Track as follows:
// !!! 	Californiyeah                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
// !!! 	Couldn't Have Known                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
// !!! 	Dancing Is The Best Revenge                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
// !!! 	Dear Can   
// (Yes, there is a valid artist named "!!!")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          


//Sort dataset by Artist_name, and track_name:
artist_track_sort := SORT(SpotMusic, artist_name, track_name);

//Output here:
OUTPUT(artist_track_sort, NAMED('Artist_Track_Sorted'));


//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Find the MOST Popular song using "Popularity" field

//Get the most Popular value (Hint: use MAX)


//Filter dataset for the mostPop value
mostPop := MAX(SpotMusic, popularity);

//Display the result - should be "Flowers" by Miley Cyrus
OUTPUT(SpotMusic(popularity = mostPop), NAMED('Most_Popular_Song'));



//*********************************************************************************
//*********************************************************************************

//                                CATEGORY TWO

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Display all games produced by "Coldplay" Artist AND has a 
//"Popularity" greater or equal to 75 ( >= 75 ) , SORT it by title.
//Count the total result

//Result has 9 records

//Get songs by defined conditions
coldplay_filter := SpotMusic(artist_name = 'Coldplay' AND popularity >= 75);

//Sort the result
coldplay_sort := SORT(coldplay_filter, track_name);

//Output the result
OUTPUT(coldplay_sort, NAMED('Coldplay_Popularity'));

//Count and output result 
coldplay_count := COUNT(coldplay_sort);
OUTPUT(coldplay_count, NAMED('Coldplay_Popularity_Count'));

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Count all songs that whose "SongDuration" (duration_ms) is between 200000 AND 250000 AND "Speechiness" is above .75 
//Hint: (Duration_ms BETWEEN 200000 AND 250000)

//Filter for required conditions
duration_filter := SpotMusic(duration_ms >= 200000 AND duration_ms <= 250000 AND speechiness > .75);                       

//Count result (should be 2153):
duration_count := COUNT(duration_filter);
//Display result:
OUTPUT(duration_count, NAMED('Duration_Count'));
//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Create a new dataset which only has "Artist", "Title" and "Year"
//Output them

//Result should only have 3 columns. 

//Hint: Create your new layout and use TRANSFORM for new fields. 
//Use PROJECT, to loop through your music dataset

//Define RECORD here:
ArtistTitleYearLayout := RECORD
    STRING artist_name;
    STRING track_name;
    UNSIGNED4 year;
END;
//Standalone TRANSFORM Here 
new_dataset := PROJECT(SpotMusic, TRANSFORM(ArtistTitleYearLayout,
    SELF.artist_name := LEFT.artist_name,
    SELF.track_name := LEFT.track_name,
    SELF.year := LEFT.year
));
//PROJECT here:

//OUTPUT your PROJECT here:
OUTPUT(new_dataset, NAMED('Artist_Title_Year'));
      

//*********************************************************************************
//*********************************************************************************

//COORELATION Challenge: 
//1- What’s the correlation between "Popularity" AND "Liveness"
//2- What’s the correlation between "Loudness" AND "Energy"

//Result for liveness = -0.05696845812100079, Energy = -0.03441566150625201

popularity_liveness := CORRELATION(SpotMusic, popularity, liveness);
//loudness_energy := CORRELATION(SpotMusic, loudness, energy);
OUTPUT(popularity_liveness, NAMED('Popularity_Liveness_Correlation'));
//OUTPUT(loudness_energy, NAMED('Loudness_Energy_Correlation'));



//*********************************************************************************
//*********************************************************************************

//                                CATEGORY THREE

//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Create a new dataset which only has following conditions
//   *  STRING Column(field) named "Song" that has "Track_Name" values
//   *  STRING Column(field) named "Artist" that has "Artist_name" values
//   *  New BOOLEAN Column called isPopular, and it's TRUE is IF "Popularity" is greater than 80
//   *  New DECIMAL3_2 Column called "Funkiness" which is  "Energy" + "Danceability"
//Display the output

//Result should have 4 columns called "Song", "Artist", "isPopular", and "Funkiness"


//Hint: Create your new layout and use TRANSFORM for new fields. 
//      Use PROJECT, to loop through your music dataset

//Define the RECORD layout
NewLayout := RECORD
    STRING song;
    STRING artist;
    BOOLEAN isPopular;
   // DECIMAL3_2 funkiness;
 
END;

//Build TRANSFORM
four_col_dataset := PROJECT(SpotMusic, TRANSFORM(NewLayout,
    SELF.song := LEFT.track_name,
    SELF.artist := LEFT.artist_name,
    SELF.isPopular := LEFT.popularity > 80,
  //  SELF.funkiness := LEFT.energy + LEFT.danceability
));

//Project here:


//Display result here:
OUTPUT(four_col_dataset, NAMED('Four_Columns_Dataset'));


                                              
//*********************************************************************************
//*********************************************************************************

//Challenge: 
//Display number of songs for each "Genre", output and count your total 

//Result has 2 col, Genre and TotalSongs, count is 82
GenreSongCount_Layout := RECORD
    SpotMusic.genre;                  
    TotalSongs := COUNT(GROUP);      
END;
//Hint: All you need is a TABLE - this is a CrossTab report 
genre_song_count := TABLE(SpotMusic, GenreSongCount_Layout, genre);

//Count and display total - there should be 82 unique genres
unique_genres := COUNT(genre_song_count);
OUTPUT(unique_genres, NAMED('Unique_Genres_Count'));
//Printing the first 50 records of the result      
OUTPUT(CHOOSEN(genre_song_count, 50), NAMED('Genre_Song_Count'));

//Bonus: What is the top genre?
sorted_genres := SORT(genre_song_count, -TotalSongs);
top_genre := CHOOSEN(sorted_genres, 1);
OUTPUT(top_genre, NAMED('Top_Genre'));

//*********************************************************************************
//*********************************************************************************
//Calculate the average "Danceability" per "Artist" for "Year" 2023

//Hint: All you need is a TABLE 

//Filter for year 2023
year_2023 := SpotMusic(year = 2023);

DanceArtist_Layout := RECORD
    year_2023.artist_name;                  
    DancableRate := AVE(year_2023.danceability);      
END;

//Result has 37600 records with two col, Artist, and DancableRate.
danceability_table := TABLE(year_2023, DanceArtist_Layout, artist_name);

//OUTPUT the result    
OUTPUT(danceability_table, NAMED('Danceability'));



