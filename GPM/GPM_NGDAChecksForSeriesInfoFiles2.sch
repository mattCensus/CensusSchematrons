<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

    <sch:let name="Title" value="/GPM/Identification_Information[1]/Citation[1]/Title[1]"/>
    <sch:let name="TitleTheme" value="substring-after($Title,'for the')"/>
    
    <sch:let name="OnlineLinkage" value="/GPM/Identification_Information[1]/Citation[1]/Online_Linkage[1]"/>
    <sch:let name="OnlineLinkageTheme" value="substring-after($OnlineLinkage,'TIGER2021/')"></sch:let>
    
    <sch:let name="NetResName" value="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]/Network_Address[1]/Network_Resource_Name[1]"/>
    <sch:let name="NetResNameTheme" value="substring-after($NetResName,'TIGER2021/')"/>
    <sch:let name="NetResNameTheme2" value="substring-before($NetResNameTheme,'/')"/>
    
    <sch:let name="MetFileId" value="/GPM/Metadata_Reference_Information[1]/Metadata_File_Identifier[1]"/>
    <sch:let name="MetFileId2" value="substring-after($MetFileId,'2021_')"/>
    <sch:let name="MetFileId3" value="substring-before($MetFileId2,'.')"/>
    <sch:let name="MetFileId4" value="upper-case($MetFileId3)"/>
    <sch:let name="MetFileId5" value="translate($MetFileId3,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>

    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Data_Set_Character_Set[1]">
            <sch:assert test="contains(.,'UTF-8')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="altTitleCount" >
        <sch:p> Making sure the alternate title exists </sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="count(Alternate_Title)=2">GPM_NGDAChecksForSeriesInfoFiles2.sch err#2: There should be two alternate title</sch:assert>
            <!-- /GPM/FGDC_Required[1]/ISO_Theme[1]/ISO_Keyword[1] -->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="ISOKeywordCheck">
        <sch:rule context="/GPM/FGDC_Required[1]/ISO_Theme[1]/ISO_Keyword[1]">
            <sch:assert test="matches(normalize-space(.),'boundaries') or matches(normalize-space(.),'transportation')">ISO_ChecksForStates.sch err#3:The first ISO_Keyword should be 'boundaries'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="NGDA_InfoCheck1">
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="matches(normalize-space(./Alternate_Title[1]),'2021')">ISO_ChecksForStates.sch err#4: The phrase "2021" is missing from the beginning
                of the first alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(./Alternate_Title[1]),'TIGER/Line Shapefile')">ISO_ChecksForStates.sch err#5: The phrase "TIGER/Line Shapefile" is missing from the beginning
                of the first alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(./Alternate_Title[2]),'NGDA')">ISO_ChecksForStates.sch err#6: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the second alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(./Alternate_Title[2]),'National Geospatial Data Asset')">ISO_ChecksForStates.sch err#7: The phrase 'National Geospatial Data Asset' is missing 
            from the second alternate title</sch:assert>
            <sch:assert test="matches(normalize-space(./NGDA_Keyword[1]),'NGDA')">ISO_ChecksForStates.sch err#8: The first NGDA Kekyword should be 'NGDA'</sch:assert>
            <sch:assert test="matches(normalize-space(./NGDA_Keyword[2]),'National Geospatial Data Asset')">ISO_ChecksForStates.sch err#9: The first NGDA Kekyword should be 'National Geospatial Data Asset'</sch:assert>
            <sch:assert test="matches(normalize-space(./NGDA_Keyword[3]),'Governmental Units and Administrative and Statistical Boundaries Theme') or matches(normalize-space(./NGDA_Keyword[3]),'Transportation Theme')">ISO_ChecksForStates.sch err#10: The first NGDA Kekyword should be 'Governmental Units and Administrative and Statistical Boundaries Theme'</sch:assert>
            <!-- /GPM/FGDC_Required[1]/NGDA_Info[1]/NGDA_Keyword[2] -->
            <!-- /GPM/FGDC_Required[1]/NGDA_Info[1]/NGDA_Keyword[1] -->
            <!-- /GPM/FGDC_Required[1]/NGDA_Info[1]/NGDA_Keyword_Thesaurus[1] -->
        </sch:rule>
    </sch:pattern>
    
    
    
    <sch:pattern id ="SeriesInfoMainTitleCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <sch:let name="MainTitle" value="."/>
            <!--  
            <sch:assert test="$AltTitle=$MainTitle">GPM_NGDAChecksForSeriesInfoFiles2.sch err#4c: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title (<sch:value-of select="$MainTitle"/>)+ (<sch:value-of select="$resourceTitle"/>) + (<sch:value-of select="$FileId"/> must match</sch:assert>
            <sch:report test="$AltTitle=$MainTitle">GPM_NGDAChecksForSeriesInfoFiles2.sch err#4d: Both the Alternate Title (<sch:value-of select="$AltTitle"/>) and the Main Title    (<sch:value-of select="$MainTitle"/>) must match> +  </sch:report>
            -->
            <sch:let name="Seriesitle" value="contains($MainTitle,'Series Information for the')"/>
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch #11: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch #12: The title name must contain 'Current'.</sch:assert>
            <sch:assert test="contains(.,', Series Information for the')">GPM_NGDAChecksForSeriesInfoFiles2.sch #13: The title must contain ', Series Information for the'  It is <sch:value-of select="/GPM/Identification_Information[1]/Citation[1]/Title[1]"/>  </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:let name="Year" value="string(contains(.,'Current'))"/> 
            <sch:assert test="$TIGERLineYes ='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch #9: The main title should include 'TIGER/Line Shapefile'</sch:assert>
            <sch:assert test="$Year='true'">ISO_ChecksForStates.sch #10: The title name must contain 'Current'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id ="Publication_DateCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Publication_Date[1]">
            <sch:assert test="contains(.,'2021')">GPM_NGDAChecksForSeriesInfoFiles2.sch #11: The year must be 2021 for the publication date</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="browseGraphicCountCheck">
        <sch:rule context="/GPM/Identification_Information[1]">
            <sch:assert test="count(./Browse_Graphic[1]/Browse_Graphic_File_Name)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch err#14: The Browse Graphic is missing</sch:assert>
            <sch:assert test="matches(./Browse_Graphic[1]/Browse_Graphic_File_Type[1],'WMS')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#14A:  The Browse Graphic File Type should be 'WMS'</sch:assert>
            <sch:assert test="string-length(./Browse_Graphic[1]/Browse_Graphic_File_Description[1])">GPM_NGDAChecksForSeriesInfoFiles2.sch err#14B: The string length for Browse Graphic File Description
            should be greater than zero
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="browseGraphicCheck2">
        <sch:rule context="/GPM/Identification_Information[1]/Browse_Graphic">
            <!--  <sch:assert test="starts-with((normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">The Browse graphic is incorrect. It should begin with 'https'</sch:assert>
           
           &VERSION
           -->
            <sch:let name="BrowseGraphicURL" value="normalize-space(Browse_Graphic_File_Name)"/>
            <sch:let name="BrowseGraphicURL5" value="substring(BrowseGraphicURL,0,5)" />
            <sch:let name="ServiceAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;SERVICE'))"/>
            <sch:let name="VersionAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;VERSION'))"/>
            <sch:let name="LAYERSAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;LAYERS'))"/>
            <sch:let name="STYLESAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;STYLES'))"/>
            <sch:let name="FORMATAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;FORMAT'))"/>
            <sch:let name="BGCOLORAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;BGCOLOR'))"/>
            <sch:let name="TRANSPARENTAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;TRANSPARENT'))"/>
            <sch:let name="CRSAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;CRS'))"/>
            <sch:let name="BBOXAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;BBOX'))"/>
            <sch:let name="WIDTHAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;WIDTH'))"/>
            <sch:let name="HEIGHTAmp" value="string(contains(./Browse_Graphic_File_Name,'&amp;HEIGHT'))"/>
            <sch:assert test="count(.)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch err#15 The Browse graphic is missing</sch:assert>
            
            <!--  <sch:assert test="starts-with(normalize-space(./gmd:fileName[1]/gco:CharacterString),'https')">Browse Graphic</sch:assert>
            
            <sch:assert test="not(contains(./Browse_Graphic_File_Name,'&amp;SERVICE'))">GPM_NGDAChecksForSeriesInfoFiles2.sch err#9: Make sure that there is an
                amp; after the ampersand for the SERVICE parameter</sch:assert>-->
            <sch:assert test="$ServiceAmp='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch err#16: Make sure that there is an
                amp; after the ampersand for the SERVICE parameter <sch:value-of select="$ServiceAmp"/> </sch:assert>
            <sch:assert test="$VersionAmp='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch err#17: Make sure that there is an
                amp; after the ampersand for the VERSION parameter.</sch:assert>
            <sch:assert test="$LAYERSAmp='true'">>GPM_NGDAChecksForSeriesInfoFiles2.sch err#18: Make sure that there is an
                amp; after the ampersand for the LAYERS parameter.</sch:assert>
            <sch:assert test="$STYLESAmp='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch err#19: Make sure that there is an
                amp; after the ampersand for the STYLES parameter. Also, remove the double ampersand.</sch:assert>
            <sch:assert test="$FORMATAmp='true'">>GPM_NGDAChecksForSeriesInfoFiles2.sch err#20: Make sure that there is an
                amp; after the ampersand for the FORMAT parameter.</sch:assert>
            <sch:assert test="$BGCOLORAmp='true'">>GPM_NGDAChecksForSeriesInfoFiles2.sch err#21: Make sure that there is an
                amp; after the ampersand for the BGCOLOR parameter.</sch:assert>
            <sch:assert test="$TRANSPARENTAmp='true'">>GPM_NGDAChecksForSeriesInfoFiles2.sch err#22: Make sure that there is an
                amp; after the ampersand for the TRANSPARENT parameter.</sch:assert>
            <sch:assert test="$CRSAmp='true'">>GPM_NGDAChecksForSeriesInfoFiles2.sch err#23: Make sure that there is an
                amp; after the ampersand for the CRS parameter.</sch:assert>
            <sch:assert test="$BBOXAmp='true'">NGDAChecksForNationalFiles.sch err#24: Make sure that there is an
                amp; after the ampersand for the BBOX parameter.</sch:assert>
            <sch:assert test="$WIDTHAmp='true'">NGDAChecksForNationalFiles.sch err#25: Make sure that there is an
                amp; after the ampersand for the WIDTH parameter.</sch:assert>
            <sch:assert test="$HEIGHTAmp='true'">NGDAChecksForNationalFiles.sch err#26: Make sure that there is an
                amp; after the ampersand for the HEIGHT parameter.</sch:assert>
        </sch:rule>
    
    </sch:pattern>
    
    <!-- Checking the NGDA keywords  and type-->
    <sch:pattern>
        <sch:p>Making sure that there are 4 keywords, 1 type and that the type is theme </sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]">
            <sch:assert test="count(NGDA_Keyword)=3">GPM_NGDAChecksForSeriesInfoFiles2.sch err#24: There are supposed to be 3 keywords</sch:assert>
            <sch:assert test="contains(./NGDA_Keyword_Thesaurus[1],'NGDA Portfolio Themes')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#25: The gmd:MD_KeywordTypeCode should contain the value 'NGDA Portfolio Themes''</sch:assert>
        </sch:rule>
    </sch:pattern>


<!-- checking for the correct place keywords -->
<sch:pattern>
    <sch:p>Making sure the value is 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:p>
    <sch:rule context="/GPM/Identification_Information[1]/Keywords[1]/Place[1]">
        <sch:assert test="matches(normalize-space(./Place_Keyword_Thesaurus[1]),'ISO 3166')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#27: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
        <sch:assert test="count(./Place_Keyword)=2">GPM_NGDAChecksForSeriesInfoFiles2.sch err#28:The number of place keywords should be 2</sch:assert>
    </sch:rule>
</sch:pattern>

    <!-- Checking the URLS -->
    <sch:pattern id="WMSandRestCheck">
        <sch:p> Checking for correct amount of URLS </sch:p>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]">
            <sch:assert test="count(Digital_Form)=3">NGDAChecksForNationalFiles.sch #25: There should be three URLs</sch:assert>
            <sch:assert test="count(./Digital_Form[1]/Network_Address[1]/Network_Resource_Name[1])=1">GPM_NGDAChecksForSeriesInfoFiles2.sch err#29: The download zip file URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(./Digital_Form[2]/Network_Address[1]/Network_Resource_Name[1])=1">GPM_NGDAChecksForSeriesInfoFiles2.sch err#30: The EAcontentInfo URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(./Digital_Form[3]/Network_Address[1]/Network_Resource_Name[1])=1">GPM_NGDAChecksForSeriesInfoFiles2.sch err#31: The Technical Documentation URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    

    <sch:pattern id="URLDownloadCheck">
        <sch:p>Checking for the zip file</sch:p>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]">
            <sch:report test="contains(./Network_Address[1]/Network_Resource_Name[1],'.zip')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#30: There should not be a zip file for the download</sch:report>
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'https')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#31: The linkage for the download URL does not contains https</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    <sch:pattern id="WMSCheck">
        <sch:p>Checking for WMS and making sure that it exists</sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/GETMAP_URL[1]">
            <sch:assert test="count(.)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch err#32:The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
            
            
            <sch:assert test="contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer')
                or contains(., 'https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer')
                or contains(., 'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_PhysicalFeatures/MapServer')">
                GPM_NGDAChecksForSeriesInfoFiles2.sch err#33: Make sure you have the correct URL for the WMS (https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb/tigerWMS_Current/MapServer ) !!</sch:assert>
            
            <sch:assert test="contains(.,'/MapServer')">GPM_NGDAChecksForSeriesInfoFiles2.sch err#34:Make sure you have the correct URL !!</sch:assert>
            <sch:assert test="string-length(.)&lt; 103">GPM_NGDAChecksForSeriesInfoFiles2.sch err#35: The length of the URL is to long</sch:assert>
            
            <!--  applicationProfile-->
            
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="RESTURLCheck">
        <sch:p>Checking for REST and making sure that it exists</sch:p>
        <sch:rule context="/GPM/FGDC_Required[1]/NGDA_Info[1]/REST_URL[1]">
            <sch:assert test="contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb') or contains(.,'https://tigerweb.geo.census.gov/arcgis/rest/services/Census2010') ">
                GPM_NGDAChecksForSeriesInfoFiles2.sch err#36: The URL for the REST URL is wrong is wrong! It should be "https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb"</sch:assert>
            
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="editionCheck">
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Edition[1]">
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:assert test="$Year='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch #37: The edition name must contain '2021'.</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="timeperiodcheck">
        <sch:rule context="/GPM/Identification_Information[1]/Time_Period_of_Content[1]">
            <sch:assert test="count(./Range_of_Dates[1])=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #38: The timeperiod is missing</sch:assert>
            <sch:let name="beginYear" value="string(contains(./Range_of_Dates[1]/Beginning_Date[1],'2020'))"/>
            <sch:let name="endYear" value="string(contains(./Range_of_Dates[1]/Ending_Date[1],'2021'))"/> 
            <sch:assert test="$beginYear='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch #39: The beginning year must be '2020'</sch:assert>
            <sch:assert test="$endYear='true'">GPM_NGDAChecksForSeriesInfoFiles2.sch #40: The ending year must be '2021'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='boundingBox'>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="/GPM/Identification_Information[1]/Spatial_Domain[1]/Bounding_Coordinates[1]">      
            <sch:assert test="not(./West_Bounding_Coordinate &lt; -180)">GPM_NGDAChecksForSeriesInfoFiles2.sch #41: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./West_Bounding_Coordinate &gt; 180)">GPM_NGDAChecksForSeriesInfoFiles2.sch #42: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(./East_Bounding_Coordinate[1] &lt; -180)">GPM_NGDAChecksForSeriesInfoFiles2.sch #43: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./East_Bounding_Coordinate[1] &lt; -180)">GPM_NGDAChecksForSeriesInfoFiles2.sch #44: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(./South_Bounding_Coordinate[1] &lt; -90)">GPM_NGDAChecksForSeriesInfoFiles2.sch #45: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(./South_Bounding_Coordinate[1] &gt; 90)">GPM_NGDAChecksForSeriesInfoFiles2.sch #46:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(./North_Bounding_Coordinate[1] &lt; -90)">GPM_NGDAChecksForSeriesInfoFiles2.sch #47: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(./North_Bounding_Coordinate[1] &gt; 90)">GPM_NGDAChecksForSeriesInfoFiles2.sch #48:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='otherRestrictionInMD_LegalConstraints'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//Constraints[1]">
            <sch:report test="/GPM/Identification_Information[1]/Constraints[1]/Access_Constraints[1]='otherRestrictions' and not(Other_Constraints)">GPM_NGDAChecksForSeriesInfoFiles2.sch #49: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="/GPM/Identification_Information[1]/Constraints[1]/Use_Constraints[2]='otherRestrictions' and not(Other_Constraints)">GPM_NGDAChecksForSeriesInfoFiles2.sch #50: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_File_Identifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">GPM_NGDAChecksForSeriesInfoFiles2.sch #51: The file id is not complete. Please fill it out.</sch:assert> 
            
        </sch:rule>
    </sch:pattern>  
    
    
    <sch:pattern id="scopeCheck">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Hierarchy_Level[1]">
            <sch:let name="hierlevel" value="."/>
            <sch:assert test=".='series'">GPM_NGDAChecksForSeriesInfoFiles2.sch #52: The hierarchy level must be 'series'. It is (<sch:value-of select="$hierlevel"/>) </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='URLConsistencyCheck'>
        <sch:rule context="/GPM">
            <sch:assert test="$OnlineLinkageTheme =$NetResNameTheme">GPM_NGDAChecksForSeriesInfoFiles2.sch #53: The OnlineLinkage (<sch:value-of select="$OnlineLinkageTheme"/>) does not equal the network resource name (<sch:value-of select="$NetResNameTheme"/>) </sch:assert>
            <sch:assert test="$NetResNameTheme2=$MetFileId5">GPM_NGDAChecksForSeriesInfoFiles2.sch #54: The network resource name (<sch:value-of select="$NetResNameTheme2"/>) does not equal the metadateFile Id (<sch:value-of select="$MetFileId5"/>)</sch:assert>
        </sch:rule>
    </sch:pattern>
    
       <sch:pattern id="yearCheckforEAdownload">
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]">
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/TIGER2021')">GPM_NGDAChecksForSeriesInfoFiles2.sch #55: The year for the download zip should contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/TIGER2020/TIGER2021'</sch:assert>
            <sch:assert test="matches(./Network_Address[1]/Mime_Type[1],'text/html')">GPM_NGDAChecksForSeriesInfoFiles2.sch #56: The value should be 'text/html'</sch:assert>
            <!-- /GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1] -->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EAURLCheck">
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[2]" >
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19110/')">GPM_NGDAChecksForSeriesInfoFiles2.sch #57: The download URL for the EA file should contain 'https://meta.geo.census.gov/data/existing/decennial/GEO/GPMB/TIGERline/Current_19110/'</sch:assert>
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'2021')">GPM_NGDAChecksForSeriesInfoFiles2.sch #58: The download URL for the EA file should contain '2021'</sch:assert>
            <sch:let name="Mime" value="./Network_Address[1]/Mime_Type[1]"/>
            <sch:assert test="contains(./Network_Address[1]/Mime_Type[1],'text/xml')">GPM_NGDAChecksForSeriesInfoFiles2.sch #59: The value should be 'text/html' It is (<sch:value-of select="$Mime"/>)</sch:assert>
            <!-- /GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[2]/Network_Address[1]/Mime_Type[1] -->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='TigerDocCheck'>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[3]">
            <sch:assert test="contains(./Network_Address[1]/Network_Resource_Name[1],'https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.html')">
                GPM_NGDAChecksForSeriesInfoFiles2.sch #59: The URL should be 'https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.html'
            </sch:assert>
            <sch:assert test="matches(./Network_Address[1]/Mime_Type[1],'text/html')">GPM_NGDAChecksForSeriesInfoFiles2.sch #60: The value should be 'text/html'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='feeCheck'>
        <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Fees[1]">
            <sch:assert test="matches(.,'The online copy of the TIGER/Line Shapefiles may be accessed without charge.')">GPM_NGDAChecksForSeriesInfoFiles2.sch #60: The fee should be
                'The online copy of the TIGER/Line Shapefiles may be accessed without charge.'
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TechPreCheck">
        <sch:rule context="/GPM/Distribution_Information[1]/Technical_Prerequisites[1]">
            <sch:assert test="contains(.,'The TIGER/Line shapefiles contain geographic data only')">GPM_NGDAChecksForSeriesInfoFiles2.sch #61: The technical prerequisites should start with 
                'The TIGER/Line shapefiles contain geographic data only'
            </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id ="MetadataContactCheck">
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Point_of_Contact[1]">
            <sch:assert test="count(./Contact_Address[1])=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #61: There should an address for the metadata Contact Information</sch:assert>
            <sch:assert test="count(./Contact_Address[1]/Address)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #62: The metadata Contact Information should have an Address</sch:assert>
            <sch:assert test="count(./Contact_Address[1]/City)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #62: The metadata Contact Information should have a City</sch:assert>
            <sch:assert test="count(./Contact_Address[1]/State_or_Province)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #63: The metadata Contact Information should have a State_or_Province</sch:assert>
            <sch:assert test="count(./Contact_Address[1]/Postal_Code)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #64: The metadata Contact Information should have a Postal_Code</sch:assert>
            <sch:assert test="count(./Contact_Address[1]/Country)=1">GPM_NGDAChecksForSeriesInfoFiles2.sch #64: The metadata Contact Information should have a Country</sch:assert>
        </sch:rule>
    </sch:pattern>
 
  <sch:pattern id="standardCheck">
      <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Standard_Name[1]">
          <sch:assert test="matches(.,'Geospatial Product Metadata Content Standard')">GPM_NGDAChecksForSeriesInfoFiles2.sch #64: The metadata standard should be 'Geospatial Product Metadata Content Standard'</sch:assert>
      </sch:rule>
  </sch:pattern>
    
   <sch:pattern id="verCheck">
       <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Standard_Version[1]">
           <sch:assert test="matches(.,'1.0')">GPM_NGDAChecksForSeriesInfoFiles2.sch #64: The metadata standard should be '1.0'</sch:assert>
       </sch:rule>
   </sch:pattern>
 
<!--  -->

</sch:schema>