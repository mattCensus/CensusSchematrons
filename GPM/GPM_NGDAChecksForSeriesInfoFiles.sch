<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi" />
    <sch:ns  prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:let name="resourceTitle"
        value="/gmd:MD_Metadata[1]/gmd:identificationInfo[1]/*[1]/gmd:citation/*[1]/gmd:title/*[1][normalize-space()]"/>
    <sch:let name="FileId" value="/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1]"/>
   
   
    
      <!-- Assert: if the test is false, then the test and file fails -->
   <!-- checking to make sure that the codelist value and characterset are correct -->
    <!-- checking to make sure that the codelist value and characterset are correct -->
    <!-- 
        Change log
        12/15/17 added the "https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer "
        WMS to the checks
    -->
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Data_Set_Character_Set[1]">
            <sch:assert test="contains(.,'UTF-8')">GPM_NGDAChecksForSeriesInfoFiles.sch err#1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
   <!-- Checking the alternate title -->
  
    <sch:pattern id="altTitleCount" >
        <sch:p> Making sure the alternate title exists </sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="count(Alternate_Title)=2">GPM_NGDAChecksForSeriesInfoFiles.sch err#2: There should be two alternate title</sch:assert>
            <sch:let name="altTitle" value="./Alternate_Title[1]"/>
            <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
            <sch:let name="altTitle" value="./Alternate_Title[2]"/>
            <sch:let name="NGDATheme" value="normalize-space($altTitle)"/>
            <sch:let name="NGDAThemeA" value="substring-after($NGDATheme,'(NGDA)')"/>
     </sch:rule>
    </sch:pattern>
       
       <!-- 
          <sch:assert test="matches(normalize-space(./Place_Keyword_Thesaurus[1]),'ISO 3166')">GPM_NGDAChecksForSeriesInfoFiles.sch err#24: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
            <sch:assert test="count(./Place_Keyword)=2"></sch:assert>
       -->
       
       
    <sch:pattern id="altTitleCheck1">
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/Alternate_Title[1]">
            <sch:assert test="matches(normalize-space(.),'2020')">GPM_NGDAChecksForSeriesInfoFiles.sch err#3: The phrase "2020" is missing from the beginning
                of the alternate title</sch:assert>
           
        </sch:rule>
    </sch:pattern>
    
    
    <!-- 
     <sch:assert test="matches(normalize-space(.,'TIGER/Line Shapefile'))">ISO_ChecksForStates.sch err#4: The phrase "TIGER/Line Shapefile" is missing from the beginning
                of the alternate title</sch:assert>
    
  
    <sch:pattern id="altTitleCheck2">
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/Alternate_Title[2]">
            <sch:assert test="matches(normalize-space(.),'NGDA')">ISO_ChecksForStates.sch err#6: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(.),'TIGER/Line Shapefile')">ISO_ChecksForStates.sch err#6: The phrase "TIGER/Line Shapefile" is missing from the beginning
                of the alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>  -->
    
    <sch:pattern id ="SeriesInfoMainTitleCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <sch:let name="MainTitle" value="."/>
            <!--  
            <sch:assert test="$AltTitle=$MainTitle">GPM_NGDAChecksForSeriesInfoFiles.sch err#4c: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title (<sch:value-of select="$MainTitle"/>)+ (<sch:value-of select="$resourceTitle"/>) + (<sch:value-of select="$FileId"/> must match</sch:assert>
            <sch:report test="$AltTitle=$MainTitle">GPM_NGDAChecksForSeriesInfoFiles.sch err#4d: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title    (<sch:value-of select="$MainTitle"/>) must match> +  </sch:report>
            -->
            <sch:let name="Seriesitle" value="contains($MainTitle,'Series Information for the')"/>
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">GPM_NGDAChecksForSeriesInfoFiles.sch #4: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">GPM_NGDAChecksForSeriesInfoFiles.sch #5: The title name must contain 'Current'.</sch:assert>
            <sch:assert test="contains(.,', Series Information for the')">GPM_NGDAChecksForSeriesInfoFiles.sch #6: The title must contain ', Series Information for the'  It is <sch:value-of select="./gmd:title[1]/gco:CharacterString[1]"/>  </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">ISO_ChecksForStates.sch #7: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">ISO_ChecksForStates.sch #8: The title name must contain '2020'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Browse Graphic -->
    
    <sch:pattern id="browseGraphicCountCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Browse_Graphic[1]">
            <sch:assert test="count(Browse_Graphic_File_Name)=1">GPM_NGDAChecksForSeriesInfoFiles.sch err#9: The Browse Graphic is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="browseGraphicCheck2">
        <sch:rule context="/GPM/Identification_Information[1]/Browse_Graphic">
            <!--  <sch:assert test="starts-with((normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">The Browse graphic is incorrect. It should begin with 'https'</sch:assert>
           
           &VERSION
           -->
            <sch:let name="BrowseGraphicURL" value="normalize-space(Browse_Graphic_File_Name)"/>
            <sch:let name="BrowseGraphicURL5" value="substring(BrowseGraphicURL,0,5)" />
            <sch:assert test="count(.)=1">GPM_NGDAChecksForSeriesInfoFiles.sch err#10: The Browse graphic is missing</sch:assert>
            
            <!--  <sch:assert test="starts-with(normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">Browse Graphic</sch:assert>-->
            
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;SERVICE'))">GPM_NGDAChecksForSeriesInfoFiles.sch err#11: Make sure that there is an
                amp; after the ampersand for the SERVICE parameter</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;VERSION'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#12: Make sure that there is an
                amp; after the ampersand for the VERSION parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;LAYERS'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#13: Make sure that there is an
                amp; after the ampersand for the LAYERS parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;&amp;STYLES'))">GPM_NGDAChecksForSeriesInfoFiles.sch err#14: Make sure that there is an
                amp; after the ampersand for the STYLES parameter. Also, remove the double ampersand.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;STYLES'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#15: Make sure that there is an
                amp; after the ampersand for the STYLES parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;FORMAT'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#16: Make sure that there is an
                amp; after the ampersand for the FORMAT parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;BGCOLOR'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#17: Make sure that there is an
                amp; after the ampersand for the BGCOLOR parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;TRANSPARENT'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#18: Make sure that there is an
                amp; after the ampersand for the TRANSPARENT parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;CRS'))">>GPM_NGDAChecksForSeriesInfoFiles.sch err#19: Make sure that there is an
                amp; after the ampersand for the CRS parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;BBOX'))">NGDAChecksForNationalFiles.sch err#20: Make sure that there is an
                amp; after the ampersand for the BBOX parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;WIDTH'))">NGDAChecksForNationalFiles.sch err#21: Make sure that there is an
                amp; after the ampersand for the WIDTH parameter.</sch:assert>
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;HEIGHT'))">NGDAChecksForNationalFiles.sch err#22: Make sure that there is an
                amp; after the ampersand for the HEIGHT parameter.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking the NGDA keywords  and type-->
    <sch:pattern>
        <sch:p>Making sure that there are 4 keywords, 1 type and that the type is theme </sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="count(NGDA_Keyword)=4">GPM_NGDAChecksForSeriesInfoFiles.sch err#23: There are supposed to be 4 keywords</sch:assert>
            <sch:assert test="contains(./NGDA_Keyword_Thesaurus[1],'NGDA Portfolio Themes')">GPM_NGDAChecksForSeriesInfoFiles.sch err#24: The gmd:MD_KeywordTypeCode should contain the value 'NGDA Portfolio Themes''</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct place keywords -->
    <sch:pattern>
        <sch:p>Making sure the value is 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:p>
        <sch:rule context="/GPM/Identification_Information[1]/Keywords[1]/Place[1]">
            <sch:assert test="matches(normalize-space(./Place_Keyword_Thesaurus[1]),'ISO 3166')">GPM_NGDAChecksForSeriesInfoFiles.sch err#25: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
            <sch:assert test="count(./Place_Keyword)=2"></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking the URLS -->
    <sch:pattern id="WMSandRestCheck">
        <sch:p> Checking for correct amount of URLS </sch:p>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]">
            <sch:assert test="count(Digital_Form)=3">NGDAChecksForNationalFiles.sch #26: There should be three URLs</sch:assert>
            <sch:assert test="count(gmd:transferOptions[1])=1">GPM_NGDAChecksForSeriesInfoFiles.sch err#27: The download zip file URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[2])=1">GPM_NGDAChecksForSeriesInfoFiles.sch err#28: The EAcontentInfo URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[3])=1">GPM_NGDAChecksForSeriesInfoFiles.sch err#30: The Technical Documentation URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
    <sch:pattern id="URLDownloadCheck">
        <sch:p>Checking for the zip file</sch:p>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]">
            <sch:report test="contains(./Network_Address[1]/Network_Resource_Name[1],'.zip')">GPM_NGDAChecksForSeriesInfoFiles.sch err#31: There should not be a zip file for the download</sch:report>
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'https')">GPM_NGDAChecksForSeriesInfoFiles.sch err#32: The linkage for the download URL does not contains https</sch:assert>
        </sch:rule>
    </sch:pattern>
      
    <!-- Checking for both the WMS and REST URLS       <sch:assert test="count(gmd:transferOptions)">GPM_NGDAChecksForSeriesInfoFiles.sch err#14: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>      -->
  
    <!-- This pattern works -->
    <sch:pattern id="WMSCheck">
         <sch:p>Checking for WMS and making sure that it exists</sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/GETMAP_URL[1]">
            <sch:assert test="count(.)=1">GPM_NGDAChecksForSeriesInfoFiles.sch err#33:The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
           
            
             <sch:assert test="contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer')
                or contains(gmd:linkage/gmd:URL, 'https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer')
                or contains(gmd:linkage/gmd:URL, 'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_PhysicalFeatures/MapServer')">
                 GPM_NGDAChecksForSeriesInfoFiles.sch err#34: Make sure you have the correct URL for the WMS (https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer ) !!</sch:assert>
            
             <sch:assert test="contains(.,'/MapServer')">GPM_NGDAChecksForSeriesInfoFiles.sch err#35:Make sure you have the correct URL !!</sch:assert>
            <sch:assert test="string-length(.)&lt; 103">GPM_NGDAChecksForSeriesInfoFiles.sch err#36: The length of the URL is to long</sch:assert>
            
            <!--  applicationProfile-->
            
        </sch:rule>
     </sch:pattern> 
    
    
    
    <sch:pattern id="RESTURLCheck">
        <sch:p>Checking for REST and making sure that it exists</sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/REST_URL[1]">
            <sch:assert test="contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb') or contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/Census2010') ">
                GPM_NGDAChecksForSeriesInfoFiles.sch err#37: The URL for the REST URL is wrong is wrong! It should be "https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb"</sch:assert>
           
        </sch:rule>
    </sch:pattern> 
    
    
    
    <sch:pattern id="editionCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Edition[1]">
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:assert test="$Year='true'">GPM_NGDAChecksForSeriesInfoFiles.sch #38: The edition name must contain '2020'.</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="timeperiodcheck">
        <sch:rule context="/GPM/Identification_Information[1]/Time_Period_of_Content[1]">
            <sch:assert test="count(./Range_of_Dates[1])=1">GPM_NGDAChecksForSeriesInfoFiles.sch #39: The timeperiod is missing</sch:assert>
            <sch:let name="beginYear" value="string(contains(./Range_of_Dates[1]/Beginning_Date[1],'2019'))"/>
            <sch:let name="endYear" value="string(contains(./Range_of_Dates[1]/Ending_Date[1],'2020'))"/> 
            <sch:assert test="$beginYear='true'">GPM_NGDAChecksForSeriesInfoFiles.sch #40: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">GPM_NGDAChecksForSeriesInfoFiles.sch #42: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='boundingBox'>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="/GPM/Identification_Information[1]/Spatial_Domain[1]/Bounding_Coordinates[1]">      
            <sch:assert test="not(./West_Bounding_Coordinate &lt; -180)">GPM_NGDAChecksForSeriesInfoFiles.sch #43: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./West_Bounding_Coordinate &gt; 180)">GPM_NGDAChecksForSeriesInfoFiles.sch #44: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(./East_Bounding_Coordinate[1] &lt; -180)">GPM_NGDAChecksForSeriesInfoFiles.sch #45: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./East_Bounding_Coordinate[1] &lt; -180)">GPM_NGDAChecksForSeriesInfoFiles.sch #46: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./South_Bounding_Coordinate[1] &lt; -90)">GPM_NGDAChecksForSeriesInfoFiles.sch #47: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(./South_Bounding_Coordinate[1] &gt; 90)">GPM_NGDAChecksForSeriesInfoFiles.sch #48:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(./North_Bounding_Coordinate[1] &lt; -90)">GPM_NGDAChecksForSeriesInfoFiles.sch #49: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(./North_Bounding_Coordinate[1] &gt; 90)">GPM_NGDAChecksForSeriesInfoFiles.sch #50:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='otherRestrictionInMD_LegalConstraints'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//Constraints[1]">
            <sch:report test="/GPM/Identification_Information[1]/Constraints[1]/Access_Constraints[1]='otherRestrictions' and not(gmd:otherConstraints)">GPM_NGDAChecksForSeriesInfoFiles.sch #51: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="/GPM/Identification_Information[1]/Constraints[1]/Use_Constraints[2]='otherRestrictions' and not(Other_Constraints)">GPM_NGDAChecksForSeriesInfoFiles.sch #52: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
   
    
   
    
    <sch:pattern id="fileId">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_File_Identifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">GPM_NGDAChecksForSeriesInfoFiles.sch #53: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>  
    
    
    <sch:pattern id="scopeCheck">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Hierarchy_Level[1]">
            <sch:let name="hierlevel" value="."/>
            <sch:assert test=".='series'">GPM_NGDAChecksForSeriesInfoFiles.sch #54: The hierarchy level must be 'series' </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    
    
    
       
   
   
</sch:schema>

