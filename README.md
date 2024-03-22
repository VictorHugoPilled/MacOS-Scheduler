# Setup Steps

## CSV Setup
1. Place the day, the script time and the full script path in the scheduler.csv. There are examples in the csv for you to follow.
   - **Don't remove the heading**, it is ignored when the script is ran, but if you do remove it, all of your scripts will not run.
   - Don't worry about the order you put the scripts in, they will be sorted in the code.
   - Days must be capitalized: Monday, Tuesday, etc.
   - Time must be written in the 24 hour format: 00:00-23:59

## Workflow setup
1. Open scheduler.workflow with automator.
2. Replace the directory here after the cd command with whatever directory you decide to leave this folder. 

	```Shell
	cd /Users/earlchase/documents/scheduler
	```

3. The script is exectuable and will run when called by the workflow so no further configuration is needed.

## Automator App Setup
1. Open automator.
2. Click on open an existing document and open scheduler.app
3. Confirm scheduler.workflow is selected as the workflow this app runs when opened.
   - You shouldn't have to change anything at all to get to work. All you are doing is confirming everything is in order.

## Calendar
1. Open your calendar and create a recurring event.
   - The first time you should set this event to run basically immediately as the calendar is going to ask you for permission to open the automator app.
   - Once you have run this one time and given the permission to run, change the date of the event to about an hour before you normally run your scripts.
2. Click on alert and choose customize.
3. Then click on the top dropdown menu that shows up and choose open a file.
4. Click on calendar and select other.
5. Select the scheduler.app
6. Click ok and you are done.

## Wrapup
- Don't worry about making your scripts executable, all scripts are ran like this:

```Shell
python3 /Users/earlchase/documents/scheduling.py
```

- If you need to run more than one script per day, this script will run them in order. 