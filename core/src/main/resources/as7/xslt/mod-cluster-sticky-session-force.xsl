<?xml version="1.0" encoding="UTF-8"?>
<!-- @author Michal Karm Babacek <mbabacek@redhat.com> -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output method="xml" indent="yes" />

    <xsl:variable name="nsModCluster" select="'urn:jboss:domain:modcluster:'" />

    <xsl:param name="pStickySessionForce" select="'@STICKY_SESSION_FORCE@'" />

    <!-- On the modcluster subsystem add the sticky-session-force attribute -->
    <xsl:template
        match="//*[local-name()='subsystem' and starts-with(namespace-uri(), $nsModCluster)]
                /*[local-name()='mod-cluster-config' and starts-with(namespace-uri(), $nsModCluster)]">
        <xsl:copy>
            <xsl:attribute name="sticky-session-force">
                <xsl:value-of select="$pStickySessionForce" />
            </xsl:attribute>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

    <!-- Copy everything else -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>

    <!-- For elements already with the sticky-session-force attribute -->
    <xsl:template
        match="//*[local-name()='subsystem' and starts-with(namespace-uri(), $nsModCluster)]
                /*[local-name()='mod-cluster-config' and starts-with(namespace-uri(), $nsModCluster)]/@sticky-session-force">
        <xsl:attribute name="sticky-session-force">
                <xsl:value-of select="$pStickySessionForce" />
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>