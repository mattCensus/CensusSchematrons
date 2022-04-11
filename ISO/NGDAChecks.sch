<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi" />
    <sch:ns prefix="gmd"  uri="http://www.isotc211.org/2005/gmd" />
    
   <!-- checking to make sure that the codelist value and characterset are correct -->
    <!-- 
    Change log
    12/14/17 added the "https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer "
    WMS to the checks
    -->
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">NGDAChecks #1: The codelist value must be equal to 'UTF-8'</sch:assert>
            <!-- <sch:assert test="contains(./@codeSpace,'004')">The codespace value for gmd:MD_CharacterSetCode must be '004' </sch:assert> -->
        </sch:rule>
    </sch:pattern>
    
   <!-- Checking the alternate title -->
    <!-- Assert: if the test is false, then the test and file fails -->
    <!-- Making sure the alternate title exists -->
    <!-- This pattern works -->
    <sch:pattern id="altTitleCount">
     <sch:rule context="gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
         <sch:assert test="count(gmd:alternateTitle)=2">NGDAChecks #2: The alternate title is missing</sch:assert>
         <sch:let name="altTitle" value="/gmd:alternateTitle/gco:CharacterString"/>
         <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
         <!--   <sch:assert test="starts-with($altTitleA,'National')">The phrase "National Geospatial Data Asset" is missing from the beginning
             of the alternate title </sch:assert>-->
     </sch:rule>
    </sch:pattern>
    
   <!--   <pattern>
        <title>gco:Date</title>
        <rule context="//gco:Date">
              
        </rule>
    </pattern>  -->
    
  <!--    <sch:pattern id="metadataDateCheck">
      <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date[1]">
            <sch:assert test="string-length(.) != 7">Date format must be YYYY-MM (7 characters) (date test)</sch:assert>  
            <sch:let name="yeara" value="."/>
            <sch:let name="yearb" value="substring($yeara,1,4)"/>
            <sch:assert test="$yearb = '2017'" >The year must be 2018. It is currently: <sch:value-of select="$yeara"/>    <sch:value-of select="$yearb"/>. Please correct it.</sch:assert>
        </sch:rule>
    </sch:pattern>-->
    
    
    <sch:pattern>
        <sch:title>gco:Date</sch:title>
        <sch:rule context="//gco:Date">
            <report test="string-length(.) != 7">NGDAChecks #3: Date format must be YYYY-MM (7 characters)</report>      
        </sch:rule>
    </sch:pattern>  
    
   <!--  <sch:pattern id="metadataDateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]">
            <sch:assert test="normalize-space(./gco:Date)='2018-06-01'">The Date must be 2018-06-01</sch:assert>
        </sch:rule>
    </sch:pattern>--> 
    
    
    
    <sch:pattern id="altTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:alternateTitle[1]/gco:CharacterString[1]">
           <!--   <sch:let name="altTitle" value="."/>
            <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
              <sch:assert test="starts-with($altTitleA,'National')">The phrase "National Geospatial Data Asset" is missing from the beginning
              of the alternate title </sch:assert>-->
            <sch:assert test="starts-with(.,'NGDA')">NGDAChecks #4: The phrase "National Geospatial Data Asset" is missing from the beginning
                of the alternate title </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking the keywords  and type-->
    <!-- Making sure that there are 3 keywords -->
    <!-- This pattern works -->
    <sch:pattern id="NGDAKeywordsCheckA">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]">
            <sch:assert test="count(gmd:keyword)=4">NGDAChecks #5: There are supposed to be RootElementsCheck keywords. There are </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="NGDAKeywordsCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]">
           
            <sch:assert test="count(gmd:type)=1">NGDAChecks #6: There is only supposed to be one type</sch:assert>
            <sch:assert test="contains(.,'theme')">NGDAChecks #7: The gmd:MD_KeywordTypeCode should contain the value 'theme''</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EAOtherCitation">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]">
            <sch:assert test="contains(./gmd:otherCitationDetails[1],'fe_2020')">NGDAChecks #8: Make sure the file is contains the "fe_2020" directory</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- data/oradata/fgdc/metaFiles/existing/decennial/GEO/GPMB/TIGERline/fe_2020  /gco:CharacterString-->
    
    
    <!--Checking for the zip file    -->
    <sch:pattern id="zipCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">
                NGDAChecks #9:  The download file should contain '.zip'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            </sch:assert>
                       <!--   <sch:assert test="contains(./gmd:name[1]/gco:CharacterString[1],'Shapefile')">
                The download file should contain Shapefile Zip File
            </sch:assert>-->
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct URL for the TIGER page -->
    <sch:pattern id="TIGERCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecks #10: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">NGDAChecks #11: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking for both the WMS and REST URLS-->
    <!-- This pattern works -->
    <sch:pattern id="WMSandRestCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]">
            <sch:assert test="count(gmd:transferOptions[3])">NGDAChecks #12: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[4])">NGDAChecks #13: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
    <!-- Checking for WMS -->
    <!-- making sure that it exists -->
    <!-- This pattern works -->
     <sch:pattern id="WMSCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[3]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1">NGDAChecks #14: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <!-- testing the linkage -->
            <sch:assert test="count(gmd:linkage)=1">NGDAChecks #15: The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'https://tigerweb.geo.census.gov/arcgis/services/TIGERweb') or contains(gmd:linkage/gmd:URL, 'https://tigerweb.geo.census.gov/arcgis/services/Census2010/tigerWMS_Census2010/MapServer/WMSServer') ">NGDAChecks #16: Make sure you have the correct URL!!</sch:assert>
            <sch:assert test="contains(gmd:linkage/gmd:URL,'/MapServer/WMSServer')">NGDAChecks #17: Make sure you have the correct URL !!</sch:assert>
            <sch:assert test="string-length(gmd:linkage/gmd:URL)&lt; 103">NGDAChecks #18: The length of the URL is to long</sch:assert>
            
            <!--  applicationProfile-->
            <sch:assert test="count(gmd:applicationProfile)=1">NGDAChecks #19: The application profile is missing for the WMS URL </sch:assert>
            <sch:assert test="count(gmd:name)=1"> NGDAChecks #20: The name is missing for WMS URL</sch:assert>
            <sch:assert test="count(gmd:description)=1"> NGDAChecks #21: The description is missing for the WMS URL</sch:assert>
            <sch:assert test="count(gmd:function)=1"> NGDAChecks #22: The function is missing for the WMS URL</sch:assert>
        </sch:rule>
     </sch:pattern> 
    
    <!-- Checking for REST-->
    <!-- making sure that it exists -->
    <!-- This pattern works -->
    <sch:pattern id="RESTURLCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[2]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1"> NGDAChecks #22: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <sch:assert test="count(gmd:linkage)=1"> NGDAChecks #23: The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1"> NGDAChecks #24: The application profile is missing for the REST URL </sch:assert>
            <sch:assert test="count(gmd:name)=1">  NGDAChecks #25: The name is missing for REST URL</sch:assert>
            <sch:assert test="count(gmd:description)=1"> NGDAChecks #26: The description is missing for the REST URL</sch:assert>
            <sch:assert test="count(gmd:function)=1"> NGDAChecks #27: The function is missing for the REST URL</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb') or contains(./gmd:linkage[1]/gmd:URL[1],'https://tigerweb.geo.census.gov/arcgis/rest/services/Census2010') ">
                NGDAChecks #28: The URL is wrong! It should be "https://tigerweb.geo.census.gov/arcgis/rest/services/TIGERweb"</sch:assert>
            <!-- http://www.esri.com/library/whitepapers/pdfs/geoservices-rest-spec.pdf -->
           <!--  <sch:assert test="contains(./gmd:applicationProfile[1]/gco:CharacterString,'http://www.esri.com')">
                Make sure the application profile is "http://www.esri.com/library/whitepapers/pdfs/geoservices-rest-spec.pdf"
                </sch:assert> 
            <sch:assert test="contains(/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:applicationProfile[1]/gco:CharacterString[1],'http://www.esri.com')">
               
                </sch:assert>
            <sch:assert test="starts-with(./gmd:applicationProfile[1]/gco:CharacterString[1],'http://www.esri.com')">
                 Make sure the application profile is "http://www.esri.com/library/whitepapers/pdfs/geoservices-rest-spec.pdf"
            </sch:assert>-->
        </sch:rule>
    </sch:pattern> 
    
    
    <sch:pattern id="URLDownloadCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(gmd:linkage)=1"> NGDAChecks #29: The linkage URL for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1"> NGDAChecks #30: The gmd:applicationProfile element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:name)=1">NGDAChecks #31: The gmd:name element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:description)=1">NGDAChecks #32: The gmd:description element for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:function)=1">NGDAChecks #33: The gmd:function element for the download URL is missing.</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">NGDAChecks #34: The linkage for the download URL does not contains https</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">NGDAChecks #35: The download file for the download URL must contain '.zip'</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://www2.census.gov/geo/tiger/TIGER2020')">NGDAChecks #36: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2020'</sch:assert>
            <sch:report test="contains(./gmd:description[1],'C:/Users')">NGDAChecks #37: This should not contain "C:/Users" </sch:report>
            <sch:let name="descriptionLength" value="string-length(./gmd:description[1]/gco:CharacterString[1])"/>
            <sch:report test="$descriptionLength>1">NGDAChecks #38: The string lenght is  <sch:value-of select="$descriptionLength"/></sch:report>
            <sch:report test="contains(./gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download!!')">NGDAChecks #39:  This attribute should not contain !!!</sch:report>
        </sch:rule>
    </sch:pattern>
    
    
    
    
    <sch:pattern id="EAURL">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]">
            <sch:assert test="contains(./gmd:URL,'/fe_2020')">NGDAChecks #40: Make sure the file is contains the "fe_2020" directory</sch:assert> 
            <!--<sch:report test="contains(./gmd:URL,'/fe_2020')">NGDAChecks #40B: Make sure the file is contains the "fe_2020" directory</sch:report>-->
        </sch:rule>
    </sch:pattern>
    
   <sch:pattern id="fileId">
       <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
           <sch:report test="contains(.,'C:/Users')">NGDAChecks #41: The file id should not contain "C:/Users" </sch:report>
       </sch:rule>
   </sch:pattern>
     
     <!-- <sch:pattern>
       
   </sch:pattern> 
    <sch:pattern id="ngdaCountLength1">
        <sch:rule
            context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1]">
            <sch:assert test="string-length(.)=4">The first keyword must be 'NGDA' string length</sch:assert>
        </sch:rule>
    </sch:pattern>
    
   <sch:pattern id="ngdaKeywordsContains1">
       <sch:rule
           context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1]">
           <sch:assert test="starts-with(.,'NGDA')">The first keyword must be 'NGDA'</sch:assert>
       </sch:rule>
   </sch:pattern> -->
   
</sch:schema>
