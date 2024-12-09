 <xd:doc>
        <xd:desc>
            <xd:p>Concats specified subfields in order they appear in marc record</xd:p>
            <xd:p>Two prameters</xd:p>
            <xd:p>$datafield: marc:datafield node to use for processing</xd:p>
            <xd:p>$codes: list of subfield codes, no spaces</xd:p>
        </xd:desc>
        <xd:param name="datafield"/>
        <xd:param name="codes"/>
    </xd:doc>
    <xsl:function name="f:subfieldSelectSpecial" xmlns:f="http://functions">
        <xsl:param name="datafield" as="node()"/>
        <xsl:param name="codes"/>
        <xsl:variable name="quotes">"</xsl:variable>
        <xsl:variable name="translatedCodes"
            select="normalize-space(translate($codes,'&#x22;&#x2c;&#xA0;','')"/>
        <!-- Selects and prints out datafield -->
        <xsl:choose>
            <xsl:when test="$translatedCodes">
                <xsl:variable name="str">
                    <xsl:for-each select="$datafield/child::*[contains($translatedCodes, @code)]">
                        <xsl:value-of select="concat(., ' ')"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:value-of select="substring($str, 1, string-length($str) - 1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="str">
                    <xsl:for-each select="$datafield/child::*[contains($codes, @code)]">
                        <xsl:value-of select="concat(., ' ')"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:value-of select="substring($str, 1, string-length($str) - 1)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
