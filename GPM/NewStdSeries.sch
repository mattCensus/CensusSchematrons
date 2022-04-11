<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:let name="FileID" value="contains(/GPM/Metadata_Reference_Information[1]/Metadata_File_Identifier[1],'KML')"/>
    <sch:let name="Title" value="contains(/GPM/Identification_Information[1]/Citation[1]/Title[1],'KML')"/>
    <sch:let name='Format' value="contains(/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[1]/Format_Name[1],'KML')"/>
    <sch:let name="AbsKML" value="contains(/GPM/Identification_Information[1]/Description[1]/Abstract[1],'KML')"/>
    <sch:let name="KeyKML" value="contains(/GPM/Identification_Information[1]/Keywords[1]/Theme[1]/Theme_Keyword[1],'KML')"/>
    <sch:let name="NRNKML" value="contains(/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[2]/Network_Address[1]/Network_Resource_Name[1],'kml')"/>
    
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Date[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="contains(.,'2020')">NewStdSeries.sch #1: The year mustbe 2020.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Online_Linkage[1]">
            <sch:assert test="contains(.,'https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html')"> NewStdSeries.sch #2: The online linkage must be https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern >
        <sch:rule context="/GPM">
            
            <sch:assert test="$FileID = $Title">NewStdSeries.sch #3: Both the title and the Filename must contain "KML'</sch:assert>
            <sch:assert test="$FileID = $KeyKML">NewStdSeries.sch #4: Both the title and the First Keyword must contain "KML'</sch:assert>
            <sch:assert test="$FileID = $NRNKML">NewStdSeries.sch #5: Both the title and the EA file must contain "KML'</sch:assert>
            <!--  <sch:assert test="$FileID = $Format">Both file id and the format must contain "KML" fileId =<sch:value-of select="$FileID"/> Format<sch:value-of select="$Format"/></sch:assert> 
            -->
           
        </sch:rule>
    </sch:pattern>

<sch:pattern>
    <sch:rule context="/GPM/Identification_Information[1]/Description[1]/Abstract[1]">
        <sch:assert test="contains(.,'scale')" >NewStdSeries.sch #6: The abstract must contain scale info</sch:assert>
        <sch:assert test="contains(.,'1:')" >NewStdSeries.sch #7: The abstract must contain scale info</sch:assert>
    </sch:rule>
</sch:pattern>
    
 <sch:pattern>
     <sch:rule context="/GPM/Distribution_Information[1]/Standard_Order_Process[1]/Digital_Form[2]">
         <sch:assert test="./Format_Name='HTML'">NewStdSeries.sch #8: The format name must be HTML</sch:assert>
         <sch:assert test="./File_Decompression_Technique='None'">NewStdSeries.sch #9: The file decompression technique must be None</sch:assert>
     </sch:rule>
 </sch:pattern>

<sch:pattern>
    <sch:rule context="/GPM/Identification_Information[1]/Citation[1]/Title[1]">
        <sch:assert test="contains(.,'Shapefile') or contains(.,'KML') or contains(.,'geodatabase')"> NewStdSeries.sch #10: The Title must contain either shapefile,KML or geodatabase</sch:assert>
    </sch:rule>
</sch:pattern>

</sch:schema>


