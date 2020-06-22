<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="iso-8859-1"%>
<%--@elvariable id="command" type="org.airsonic.player.command.SearchCommand"--%>

<html><head>
    <%@ include file="head.jsp" %>
    <%@ include file="jquery.jsp" %>

    <script type="text/javascript" language="javascript">

        function showMoreArtists() {
            $('.artistRow').show(); $('#moreArtists').hide();
        }

        function showMoreAlbums() {
            $('.albumRow').show(); $('#moreAlbums').hide();
        }

        function showMoreSongs() {
            $('.songRow').show();$('#moreSongs').hide();
        }

    </script>
</head>
<body class="mainframe bgcolor1">

<h1>
    <img src="<spring:theme code='searchImage'/>" alt=""/>
    <span style="vertical-align: middle"><fmt:message key="search.title"/></span>
</h1>

<c:if test="${command.indexBeingCreated}">
    <p class="warning"><fmt:message key="search.index"/></p>
</c:if>

<c:if test="${not command.indexBeingCreated and empty command.artists and empty command.albums and empty command.songs}">
    <p class="warning"><fmt:message key="search.hits.none"/></p>
</c:if>

<c:if test="${not empty command.artists}">
    <h2><b><fmt:message key="search.hits.artists"/></b></h2>
    <table class="music indent">

            <c:if test="${0 ne fn:length( command.artists ) && (command.composerVisible || command.genreVisible)}">
                <thead>
                    <tr>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"><fmt:message key="common.fields.filebaseartist" /></th>
                    </tr>
                </thead>
            </c:if>

            <c:forEach items="${command.artists}" var="match" varStatus="loopStatus">

            <sub:url value="/main.view" var="mainUrl">
                <sub:param name="path" value="${match.path}"/>
            </sub:url>

            <tr class="artistRow" ${loopStatus.count > 5 ? "style='display:none'" : ""}>
                <c:import url="playButtons.jsp">
                    <c:param name="id" value="${match.id}"/>
                    <c:param name="playEnabled" value="${command.user.streamRole and not command.partyModeEnabled}"/>
                    <c:param name="addEnabled" value="${command.user.streamRole and (not command.partyModeEnabled or not match.directory)}"/>
                    <c:param name="asTable" value="true"/>
                </c:import>
                <td class="truncate"><a href="${mainUrl}">${fn:escapeXml(match.name)}</a></td>
            </tr>

            </c:forEach>
    </table>
    <c:if test="${fn:length(command.artists) gt 5}">
        <div id="moreArtists" class="forward"><a href="javascript:showMoreArtists()"><fmt:message key="search.hits.more"/></a></div>
    </c:if>
</c:if>

<c:if test="${not empty command.albums}">
    <h2><b><fmt:message key="search.hits.albums"/></b></h2>
    <table class="music indent">

            <c:if test="${0 ne fn:length( command.albums ) && (command.composerVisible || command.genreVisible)}">
                <thead>
                    <tr>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate searchAlbumAlbum"><fmt:message key="common.fields.album" /></th>
                        <th class="truncate 
                        <c:choose>
                            <c:when test='${command.composerVisible && command.genreVisible}'>searchAlbumAlbumartist1</c:when>
                            <c:when test='${command.genreVisible}'>searchAlbumAlbumartist2</c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                        "><fmt:message key="common.fields.albumartist" /></th>
                        <c:if test="${command.genreVisible}">
                            <th class="truncate"><fmt:message key="common.fields.genre" /></th>
                        </c:if>
                    </tr>
                </thead>
            </c:if>

            <c:forEach items="${command.albums}" var="match" varStatus="loopStatus">

            <sub:url value="/main.view" var="mainUrl">
                <sub:param name="path" value="${match.path}"/>
            </sub:url>

            <tr class="albumRow" ${loopStatus.count > 5 ? "style='display:none'" : ""}>
                <c:import url="playButtons.jsp">
                    <c:param name="id" value="${match.id}"/>
                    <c:param name="playEnabled" value="${command.user.streamRole and not command.partyModeEnabled}"/>
                    <c:param name="addEnabled" value="${command.user.streamRole and (not command.partyModeEnabled or not match.directory)}"/>
                    <c:param name="asTable" value="true"/>
                </c:import>
                <td class="truncate"><a href="${mainUrl}">${fn:escapeXml(match.albumName)}</a></td>
                <td class="truncate"><span class="detail">${fn:escapeXml(match.artist)}</span></td>
                <c:if test="${command.genreVisible}">
                    <td class="truncate"><span class="detail">${fn:escapeXml(match.genre)}</span></td>
                </c:if>
            </tr>

            </c:forEach>
    </table>
    <c:if test="${fn:length(command.albums) gt 5}">
        <div id="moreAlbums" class="forward"><a href="javascript:showMoreAlbums()"><fmt:message key="search.hits.more"/></a></div>
    </c:if>
</c:if>


<c:if test="${not empty command.songs}">
    <h2><b><fmt:message key="search.hits.songs"/></b></h2>
    <table class="music indent">

            <c:if test="${0 ne fn:length( command.songs ) && (command.composerVisible || command.genreVisible) }">
                <thead>
                    <tr>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate"></th>
                        <th class="truncate searchSongTitle"><fmt:message key="common.fields.songtitle" /></th>
                        <th class="truncate searchSongAlbum"><fmt:message key="common.fields.album" /></th>
                        <th class="truncate searchSongArtist"><fmt:message key="common.fields.artist" /></th>
                        <c:if test="${command.composerVisible}">
                            <th class="truncate 
                            <c:if test='${command.genreVisible}'>searchSongArtist</c:if>
                            "><fmt:message key="common.fields.composer" /></th>
                        </c:if>
                        <c:if test="${command.genreVisible}">
                            <th class="truncate"><fmt:message key="common.fields.genre" /></th>
                        </c:if>
                    </tr>
                </thead>
            </c:if>

            <c:forEach items="${command.songs}" var="match" varStatus="loopStatus">

            <sub:url value="/main.view" var="mainUrl">
                <sub:param name="path" value="${match.parentPath}"/>
            </sub:url>
            <tr class="songRow" ${loopStatus.count > 15 ? "style='display:none'" : ""}>
                <c:import url="playButtons.jsp">
                    <c:param name="id" value="${match.id}"/>
                    <c:param name="playEnabled" value="${command.user.streamRole and not command.partyModeEnabled}"/>
                    <c:param name="addEnabled" value="${command.user.streamRole and (not command.partyModeEnabled or not match.directory)}"/>
                    <c:param name="video" value="${match.video and command.player.web}"/>
                    <c:param name="asTable" value="true"/>
                </c:import>

                <td class="truncate"><span class="songTitle">${fn:escapeXml(match.title)}</span></td>
                <td class="truncate"><a href="${mainUrl}"><span class="detail">${fn:escapeXml(match.albumName)}</span></a></td>
                <td class="truncate"><span class="detail">${fn:escapeXml(match.artist)}</span></td>
                <c:if test="${command.composerVisible}">
                    <td class="truncate"><span class="detail">${fn:escapeXml(match.composer)}</span></td>
                </c:if>
                <c:if test="${command.genreVisible}">
                    <td class="truncate"><span class="detail">${fn:escapeXml(match.genre)}</span></td>
                </c:if>
            </tr>

            </c:forEach>
    </table>
<c:if test="${fn:length(command.songs) gt 15}">
    <div id="moreSongs" class="forward"><a href="javascript:showMoreSongs()"><fmt:message key="search.hits.more"/></a></div>
</c:if>
</c:if>

</body></html>