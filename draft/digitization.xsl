<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.loc.gov/MARC21/slim" xmlns:f="http://functions"
    xmlns:local="http://www.loc.org/namespace" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="f local marc xd xlink xs xsi">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="group-945"/>
    <xsl:strip-space elements="*"/>

    <xd:doc id="digitization.xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Original author: </xd:b>Carlos Martinez III</xd:p>
            <xd:p><xd:b>Created on: </xd:b>November 18, 2024</xd:p>
            <xd:p><xd:b>Modified by: </xd:b>Carlos Martinez</xd:p>
            <xd:p><xd:b>Date last modified: </xd:b>December 5, 2024</xd:p>
            <xd:p><xd:b>Purpose: </xd:b>This stylesheet concatenates marc subfields "a","p" and "v"
                within local datafield, "945". The purpose is to capture DigiMet data.</xd:p>
        </xd:desc></xd:doc>
    <!-- Maintenance note: For each revision, change revision number
	digitization.xsl
	
	Revision 1.01 - Additional changes logged here cm3 
	Revision 1.00 - Added Log Comment  2024/12/05 09:42:42  cm3
     -->

    <xsl:include href="NAL-MARC21slimUtils.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xd:doc><xd:desc>Identity template</xd:desc></xd:doc>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:copy-of select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <xd:doc id="root" scope="component"><xd:p>Root: wraps marc:records in the marc:collection document node</xd:p></xd:doc>
    <xsl:template match="/">
        <xsl:result-document version="1.0" encoding="utf-8" format="group-945"
            href="{replace(base-uri(),'(.*/)(.*)(\.xml)','$1')}N-{replace(base-uri(), '(.*/)(.*)(\.xml)','$2')}_{position()}.xml">
            <marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                <xsl:apply-templates select="//marc:record"/>
            </marc:collection>
        </xsl:result-document>
    </xsl:template>

    <xd:doc id="marc:record" scope="component"><xd:desc>Rebuilds marc:record according to the project output requirements.</xd:desc></xd:doc>
    <xsl:template match="marc:record">
        <marc:record>
            <xsl:copy-of xml:space="preserve" select="marc:leader"/>
            <xsl:copy-of xml:space="preserve" select="marc:controlfield"/>
            <xsl:copy-of select="marc:datafield[@tag &lt; '945']"/>
            <!-- legacy 945 $d, $e, $f, $g, and $n  -->
            <xsl:if
                test="marc:datafield[@tag = '945']/marc:subfield[1][@code = 'd' or @code = 'e' or @code = 'f' or @code = 'g' or @code = 'n']">
                <marc:datafield tag="945" ind1=" " ind2=" ">
                    <xsl:apply-templates select="marc:datafield[@tag = '945']" mode="#default"/>
                </marc:datafield>
            </xsl:if>
            <!-- DigiMet 945 -->
            <marc:datafield tag="945" ind1=" " ind2=" ">
                <xsl:for-each-group select="marc:datafield[@tag = '945']" group-by="child::node()">
                    <xsl:for-each select="*">
                        <!-- subfield $a -->
                        <xsl:apply-templates select="../marc:subfield[@code = 'a']">
                            <xsl:with-param name="subfieldCode" select="@*"/>
                        </xsl:apply-templates>
                        <!-- subfield $v -->
                        <xsl:apply-templates select="../marc:subfield[@code = 'v']">
                            <xsl:with-param name="subfieldCode" select="@*"/>
                        </xsl:apply-templates>
                        <!-- subfield $p -->
                        <xsl:apply-templates select="../marc:subfield[@code = 'p']">
                            <xsl:with-param name="subfieldCode" select="@*"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </xsl:for-each-group>
            </marc:datafield>
            <xsl:copy-of xml:space="preserve" select="marc:datafield[@tag > '945']"/>
        </marc:record>
    </xsl:template>

    <xd:doc id="legacy" scope="component"><xd:desc>Calls subfields for legacy data</xd:desc></xd:doc>
    <xsl:template match="marc:datafield[@tag = '945']" mode="#default">
        <xsl:for-each-group select="*" group-by="descendant::node()">
            <xsl:apply-templates
                select="../marc:subfield[1][@code = 'd' or @code = 'e' or @code = 'f' or @code = 'g' or @code = 'n']"
                mode="subfield">
                <xsl:with-param name="subfieldCode" select="@*"/>
            </xsl:apply-templates>
        </xsl:for-each-group>
    </xsl:template>

    <xd:doc id="subfield" scope="component"><xd:desc>Used for both legacy and digimet subfield processing.</xd:desc><xd:param name="subfieldCode"/></xd:doc>
    <xsl:template match="marc:subfield[@code]" mode="subfield">
        <xsl:param name="subfieldCode"/>
        <!-- atomic needs to cast as node -->
        <xsl:variable name="atomic" select="current-grouping-key()"/>
        <xsl:variable name="newNode">
            <xsl:element name="node">
                <xsl:value-of select="$atomic"/>
            </xsl:element>
        </xsl:variable>
        <xsl:for-each select="current-grouping-key()">
            <!-- cast as a node -->
            <marc:subfield code="{$subfieldCode}">
                <xsl:copy-of select="f:subfieldSelectSpecial($newNode, current-grouping-key())"/>
            </marc:subfield>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
