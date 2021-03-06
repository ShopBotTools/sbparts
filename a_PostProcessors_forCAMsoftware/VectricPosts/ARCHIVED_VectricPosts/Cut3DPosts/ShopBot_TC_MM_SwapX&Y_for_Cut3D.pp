+-----------------------------------------------------------
|												
| ShopBot configuration file 
|
|-----------------------------------------------------------
|
| Who     When       What
| ======  ========== ========================================
| Tony M  22/06/2005 Written
| Brian M 08/07/2005 Modified to output feed units correctly
| Brian M 14/07/2005 Modified to output 6 d.p
| PACO    15/08/05   Added router control for SB3 Alpha and 
|                    router/spindle RPM dislay/prompt
| Tony    27/06/2006 Added NEW_SEGMENT section
|                    in case new tool has different 
|                    feedrates to first tool
| Brian M 14/07/2006 Added circular arC support
| ScottJ  31/10/2007 setup file for PartWorks to keep look consistant
| ScottJ  12/05/2009 Fixed issue with mutiple toolpaths not remaining at SaFE Z 
| ScottJ  11/12/2009 Added File info to headerChanged to simplified post format
| TedH    12/26/2010 Enable DIRECT for Beta ShopBotEASY
| RyanP   12/09/2011 Corrected return home after new segment. Removed JH replaced with PW variables for home position
| MattS   2/18/2016  Removed Direct output for compatibility with Cut3d/partworks3D
| MattS   2/18/2016  Swapped x and y axis, removed jog home in x&y at end of cut, removed arcs
| MattS   2/19/2015  changed to MM
+-----------------------------------------------------------

POST_NAME = "Shopbot TC(MM) Swap X&Y for Cut3D(*.sbp)"

FILE_EXTENSION = "sbp"

UNITS = "MM"

+------------------------------------------------
|    line terminating characteRS
+------------------------------------------------

LINE_ENDING = "[13][10]"

+------------------------------------------------
|    Block Numbering
+------------------------------------------------

LINE_NUMBER_START     = 0
LINE_NUMBER_INCREMENT = 10
LINE_NUMBER_MAXIMUM   = 999999

+================================================
+
+    default formating for variables
+
+================================================

+------------------------------------------------
+ Line numbering
+------------------------------------------------

var LINE_NUMBER   = [N|A|N|1.0]

+------------------------------------------------
+ Spindle Speed
+------------------------------------------------

var SPINDLE_SPEED = [S|A||1.0]

+------------------------------------------------
+ Feed Rate
+------------------------------------------------

var CUT_RATE    = [FC|A||1.1|0.0166]
var PLUNGE_RATE = [FP|A||1.1|0.0166]

+------------------------------------------------
+ Tool position in x,y and z
+------------------------------------------------

var X_POSITION = [X|A||1.6]
var Y_POSITION = [Y|A||1.6]
var Z_POSITION = [Z|A||1.6]

+------------------------------------------------
+ Home tool positions 
+------------------------------------------------

var X_HOME_POSITION = [XH|A||1.6]
var Y_HOME_POSITION = [YH|A||1.6]
var Z_HOME_POSITION = [ZH|A||1.6]


+================================================
+
+    Block definitions for toolpath output
+
+================================================


+---------------------------------------------
+                Start of file
+---------------------------------------------

begin HEADER
"'----------------------------------------------------------------"
"'SHOPBOT ROUTER FILE IN INCHES"
"'GENERATED BY Cut3D or Partworks3D"
"'Minimum extent in X = [YMIN] Minimum extent in Y = [XMIN] Minimum extent in Z = [ZMIN]"
"'Maximum extent in X = [YMAX] Maximum extent in Y = [XMAX] Maximum extent in Z = [ZMAX]"
"'Length of material in X = [YLENGTH]"
"'Length of material in Y = [XLENGTH]"
"'Depth of material in Z = [ZLENGTH]"
"'Home Position Information = [XY_ORIGIN], [Z_ORIGIN]"
"'Home Z = [ZH]"
"'Rapid clearance gap or Safe Z = [SAFEZ]"
"'UNITS:Inches"
"'"
"IF %(25)=1 THEN GOTO UNIT_ERROR	'check to see software is set to standard"
"SA                             	'Set program to absolute coordinate mode"
"CN, 90"
"'New Path"
"'Toolpath Name = [TOOLPATH_NAME]"
"'Tool Name   = [TOOLNAME]"
""
"&PWSafeZ = [SAFEZ]"
"&PWZorigin = [Z_ORIGIN]"
"&PWMaterial = [ZLENGTH]"

"'&ToolName = [34][TOOLNAME][34]"
"&Tool =[T]           'Tool number to change to"
"C9                   'Change tool"
"TR,[S]               'Set spindle RPM"			
"C6                   'Spindle on"
"PAUSE 2"
"'"
"MS,[FC],[FP]"
"JZ,[ZH]"


+--------------------------------------------
+               Program moves
+--------------------------------------------

begin RAPID_MOVE

"J3,[Y],[X],[Z]"


+---------------------------------------------

begin FIRST_FEED_MOVE

"M3,[Y],[X],[Z]"


+---------------------------------------------

begin FEED_MOVE

"M3,[Y],[X],[Z]"

+---------------------------------------------------
+  Commands output at toolchange
+---------------------------------------------------

begin TOOLCHANGE
"C7"
"'New Path"
"'Toolpath Name = [TOOLPATH_NAME]"
"'Tool Name   = [TOOLNAME]"
"&TOOL=[T]"
"C9"
"TR, [S]"
"C6"
"MS,[FC],[FP]"	    


+---------------------------------------------------
+  Commands output for a new segment - toolpath
+  with same toolnumber but maybe different feedrates
+---------------------------------------------------

begin NEW_SEGMENT
"'New Path"
"TR, [S]"

"MS,[FC],[FP]"
"JZ,[ZH]"
+---------------------------------------------
+                 end of file
+---------------------------------------------

begin FOOTER

"JZ,[ZH]"
"'"
"'Turning router OFF"
"C7"
"END"
"'"
"UNIT_ERROR:"				
"CN, 91                            'Run file explaining unit error"
"END"