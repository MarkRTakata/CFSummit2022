<cfif isDefined("FORM.submit")>
	<cfif isDefined("FORM.sessionid")>
		<cfquery name="insertnewschedule" datasource="YOURDATASOURCE">
			UPDATE tbl_schedule
			SET  displayorder = "#FORM.displayorder#", session_day = "#FORM.session_day#",session_name = "#FORM.session_name#",speakers = "#FORM.speakers#",utctime = "#FORM.utctime#", active = #FORM.active#
			WHERE id = #FORM.sessionid#
		</cfquery>
		<cflocation url="schedule-edit.cfm" addToken="no" /> 
	<cfelse>
		<cfquery name="insertnewschedule" datasource="YOURDATASOURCE">
			INSERT INTO tbl_schedule (displayorder,session_day, session_name, speakers, utctime, active)
			VALUES ("#FORM.displayorder#","#FORM.session_day#","#FORM.session_name#","#FORM.speakers#","#FORM.utctime#", #FORM.active#)
		</cfquery>
	</cfif>
</cfif>
<cfif isDefined("URL.action") AND URL.action EQ "edit">
	<cfquery datasource="YOURDATASOURCE" name="getschedule" >
		SELECT id, displayorder,session_day, session_name, speakers, utctime, active
		FROM tbl_schedule
		WHERE id = #URL.id#
	</cfquery>
</cfif>
<cfquery datasource="YOURDATASOURCE" name="getschedules" >
SELECT id, displayorder,session_day, session_name, speakers, utctime, active
FROM tbl_schedule
</cfquery>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Schedule Editor</title>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<style>
body {
  padding: 50px;
}
</style>
</head>
<body>
<h1>INSERT NEW TALK</h1>
<cfoutput>
<form action="schedule-edit.cfm" method="post" name="insertnew">
<cfif isDefined("getschedule.id")>
	<input type="hidden" name="sessionid" id="sessionid" value="#getschedule.id#" />
</cfif>
<label for="session_day">Session Day</label><br />
<input class="form-control" type="text" name="session_day" id="session_day" value="<cfif isDefined("getschedule.session_day")>#getschedule.session_day#</cfif>" /><br />
<label for="session_name">Session Name</label><br />
<input class="form-control" type="text" name="session_name" id="session_name" value="<cfif isDefined("getschedule.session_name")>#getschedule.session_name#</cfif>" /><br />
<label for="speakers">Speakers</label><br />
<input class="form-control" type="text" name="speakers" id="speakers" value="<cfif isDefined("getschedule.speakers")>#getschedule.speakers#</cfif>" /><br />
<label for="utctime">Date/Time (UTC)</label><br />
<input class="form-control" type="text" name="utctime" id="utctime" value="<cfif isDefined("getschedule.utctime")>#getschedule.utctime#</cfif>" /><br />
<label for="displayorder">Display Order</label><br />
<input class="form-control" type="number" name="displayorder" id="displayorder" value="<cfif isDefined("getschedule.displayorder")>#getschedule.displayorder#</cfif>" /><br />
<label for="active">Active?</label>
<select name="active" id="active">
	<option value="0"<cfif isDefined("getschedule.active")><cfif getschedule.active EQ 0> selected</cfif></cfif>>No</option>
	<option value="1"<cfif isDefined("getschedule.active")><cfif getschedule.active EQ 1> selected</cfif></cfif>>Yes</option>
</select><br />
<button type="submit" name="submit" id="submit" class="btn btn-success">SUBMIT</button>
</form>
</cfoutput>
</br />
<h2>Sessions</h2>
<table class="table">
	<thead>
		<tr>
			<th>Name</th>
			<th>Day</th>
			<th>Speakers</th>
			<th>Date/Time (UTC)</th>
			<th>Display Order</th>
			<th>Active</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
<cfoutput query="getschedules">
		<tr>
			<td>#session_name#</td>
			<td>#session_day#</td>
			<td>#speakers#</td>
			<td>#utctime#</td>
			<td>#displayorder#</td>
			<td>#active#</td>
			<td><a href="schedule-edit.cfm?action=edit&id=#id#" class="btn btn-sm btn-success">EDIT</a>
		</tr>
</cfoutput>

<!--- scripts --->
	<!--- JQuery --->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!--- HTMX --->
	<script src="https://unpkg.com/htmx.org@1.4.1"></script>
	<!--- Bootstrap --->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	
</body>
</html>