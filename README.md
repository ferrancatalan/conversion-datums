# WGS84 to ED50 Coordinate Converter

This MATLAB project converts geodetic coordinates from the WGS84 datum to the ED50 datum using a 3-parameter transformation (?X, ?Y, ?Z). It supports individual and batch coordinate conversion.

[![](https://mermaid.ink/img/pako:eNqFjctugzAURH_FumuCDJjYWFUkAlU3dNOH2iZ04cYOoAY7ckB9IP69DlUrlU1ndWd0Zu4AOyMVcNgfzNuuFrZDxU2pkVO6fbi6ZQTl6d399cWLXRVFijJjrGy06NTpGS0WK7SeU49Pmz_U99h6grPtZR7j_9hsYvMZO_8OHlS2kcA72ysPWmVbcbYwnFdK6GrVqhK4O6WwryWUenSdo9AbY9qfmjV9VQPfi8PJuf4o3XbeiMqK9je1SktlM9PrDnhCpw3gA7wDDwj2l8ESh5RFIY6CMPbgw8Ux85OIEkYoCcIAJ2T04HN6i31GY-wUJpQRTBM2fgGOynPW?type=png)](https://mermaid.live/edit#pako:eNqFjctugzAURH_FumuCDJjYWFUkAlU3dNOH2iZ04cYOoAY7ckB9IP69DlUrlU1ndWd0Zu4AOyMVcNgfzNuuFrZDxU2pkVO6fbi6ZQTl6d399cWLXRVFijJjrGy06NTpGS0WK7SeU49Pmz_U99h6grPtZR7j_9hsYvMZO_8OHlS2kcA72ysPWmVbcbYwnFdK6GrVqhK4O6WwryWUenSdo9AbY9qfmjV9VQPfi8PJuf4o3XbeiMqK9je1SktlM9PrDnhCpw3gA7wDDwj2l8ESh5RFIY6CMPbgw8Ux85OIEkYoCcIAJ2T04HN6i31GY-wUJpQRTBM2fgGOynPW)

## :rocket: How to use

1. Prepare your input data

   Create a file named `data.txt` inside the `data/` folder. Each line must contain:

    - longitude latitude height
    - Longitude and latitude in degrees (WGS84)
    - Height in meters

    *Example*:

    ```
    -3.7038 40.4168 667
    
    -0.3750 39.4699 15
    
    1.5197 41.3825 20
    ```
    
2. Run the example script in MATLAB
    1. Open MATLAB
    2. Navigate to the examples/ folder
    3. Run the script:

    ```
    matlab
    addpath('../src');
    convert_from_file_example
    ```

    This script will:
    - Load the WGS84 coordinates from data/data.txt
    - Convert them to ED50
    - Save the results to data/dataOutput.txt

3. Output format

    The output file will contain:


    longitude_ED50, latitude_ED50, height_ED50


    Example:

    ```
    -3.7048236712, 40.4179612348, 665.32947219
    -0.3760533289, 39.4709981237, 13.75838202
    1.5186032376, 41.3834232125, 18.60388215
    ```
## :arrows_clockwise: Coordinate Transformation Flow

The diagram below shows the step-by-step transformation process from WGS84 to ED50:

mermaid
flowchart LR
A[WGS84 DATUM<br>LLA Coordinates] --> B[WGS84 DATUM<br>XYZ Coordinates]
B --> C[ED50 DATUM<br>XYZ Coordinates]
C --> D[ED50 DATUM<br>LLA Coordinates]

- *LLA*: Latitude, Longitude, Altitude
- *XYZ*: Cartesian coordinates
- The conversion applies a simple 3-parameter shift (?X, ?Y, ?Z) in XYZ space between the datums.

## :pushpin: Notes

- The function is vectorized and supports processing multiple coordinates at once.
- Compatible with base MATLAB (no extra toolboxes required).
- Output is written as a .txt file but can easily be adapted to .csv.


## :page_with_curl: License

This project is licensed under the [MIT License](LICENSE).


## :astronaut: Credits

Created to assist in geospatial coordinate transformations between WGS84 and ED50 datums.