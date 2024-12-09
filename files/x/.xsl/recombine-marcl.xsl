<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.loc.gov/zing/srw/" xmlns:zs="http://www.loc.gov/zing/srw/"
    xmlns:mods="http://www.loc.gov/MARC21/slim" xmlns:f="http://functions"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xd xlink xs xsi zs mods f" >
    <xsl:output name="combine" method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> April 12, 2024</xd:p>
            <xd:p><xd:b>Author:</xd:b> Carlos Martinez III</xd:p>
            <xd:p><xd:b>Purpose:</xd:b>Combines XML documents.</xd:p>
            <xd:ul>
                <xd:li>1. Open or build the "<xd:i>collection_#.xml</xd:i>" document.*</xd:li>
                <xd:li>2. Create a transformation scenario: <xd:ul>
                        <xd:li>(a) declare the "<xd:i>collection_#.xml</xd:i>"  as the target XML
                            document, and, </xd:li>
                        <xd:li>(b) "<xd:i>Alma_SRU_combine.xsl</xd:i>"  as the XSLT file.</xd:li>
                        <xd:li>(c) Name the scenario and save it.</xd:li>
                    </xd:ul></xd:li>
                <xd:li>3. Select and run the transformation scenario over the test files in a directory.</xd:li>
            </xd:ul>
            <xd:p>*For information on constructing the "<xd:i>collection_#.xml</xd:i>" , please
                refer to the ReadMe.md</xd:p>
        </xd:desc>
        <xd:param name="fileName">
            <xd:p>Tokenizes forward slashes found within the base-uri()'s file/directory path
                structure. Upon reaching the last forward slash, the XPath processes the instruction
                subtract 4 directories backwards. This original file name from part of the nested
                directory name </xd:p>
        </xd:param>
        <xd:param name="fileNumber">
            <xd:p>Tokenizes forward slashes found within the base-uri()'s file/directory path
                structure. Upon reaching the last forward slash, the XPath processes the instruction
                subtract 4 directories backwards. Uses the replace function to select only the file
                number from the whole file name to accurately name the output file.</xd:p>
        </xd:param>
        <xd:param name="workingDir"/>
    </xd:doc>

    <xsl:variable name="collection-index" as="node()*" select="collection('collection_002.xml')"/>
    <xsl:variable name="mms-id" select="$collection-index//zs:searchRetrieveResponse/zs:records/zs:record/zs:recordIdentifier"/> 
    <xsl:variable name="zs_recordData">
        <xsl:copy-of select="$collection-index/zs:searchRetrieveResponse/zs:records/zs:record/zs:recordData/node()"/>
        </xsl:variable>
        
    <xd:doc>
        <xd:desc>root template</xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <!-- mms-id-collection_#.xml -->
        <xsl:result-document method="xml" encoding="utf-8" indent="yes" version="1.0" href="{replace(base-uri(),'(.*/)(.*)(\.xml)', '$1')}mms-id-{replace(base-uri(),'(.*/)(.*)(\.xml)', '$2')}.xml">
         <mms-id>
            <xsl:for-each select="$mms-id">          
            <xsl:copy-of select="." xmlns=""/>           
            </xsl:for-each>
         </mms-id>
        </xsl:result-document>
        <!-- SRU-collection_#.xml -->
         <xsl:result-document method="xml" encoding="utf-8" indent="yes" version="1.0" href="{replace(base-uri(),'(.*/)(.*)(\.xml)', '$1')}SRU-{replace(base-uri(),'(.*/)(.*)(\.xml)', '$2')}.xml">
             <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                 <xsl:for-each select="f:add-namespace-prefix($zs_recordData,'http://www.loc.gov/MARC21/slim','marc')">
                     <xsl:copy-of select="."/>
                 </xsl:for-each>
             </marc:collection>
         </xsl:result-document>
                  
    </xsl:template>
    <xd:doc>
        <xd:desc>funtion:add-namespace-prefix.</xd:desc>
        <xd:param name="elements"/>
        <xd:param name="add-namespace"/>
        <xd:param name="add-prefix"/>
    </xd:doc>
    <xsl:function name="f:add-namespace-prefix" as="node()*">
            <xsl:param name="elements" as="node()*"/>
            <xsl:param name="add-namespace" as="xs:string"/>
            <xsl:param name="add-prefix" as="xs:string"/>
            <xsl:for-each select="$elements">
                <xsl:variable name="element" select="."/>
                <xsl:choose>
                    <xsl:when test="$element instance of element()">
                        <xsl:element name="{concat($add-prefix,
                            if ($add-prefix = '')
                            then ''
                            else ':',
                            local-name($element))}" namespace="{$add-namespace}">
                            <xsl:sequence select="
                                ($element/@*,
                                f:add-namespace-prefix($element/node(),
                                $add-namespace, $add-prefix))"/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="$element instance of document-node()">
                        <xsl:document>
                            <xsl:sequence select="
                                f:add-namespace-prefix(
                                $element/node(), $add-namespace, $add-prefix)"/>
                        </xsl:document>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="$element"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:function>

</xsl:stylesheet>
