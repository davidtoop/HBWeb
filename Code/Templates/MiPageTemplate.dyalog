:Class MiPageTemplate : #.MiPage
⍝ This is a template that adds a consistent header to all pages based on it

    ∇ {r}←Wrap;lang;header;home;menu;wrapper;mul
      :Access Public
     
      Insert _html.meta''('name="viewport" content="width=device-width, initial-scale=1.0"')
      Insert _html.meta''('http-equiv="X-UA-Compatible" content="ie=edge"')
     
   ⍝ ⍝ set the tab/window title to the name of the application defined in Config/Server.xml
      Head.Add _.title _Request.Server.Config.Name
      Head.Add _.script''('defer="" src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"')
     
   ⍝ ⍝ add a link to our CSS stylesheet
      _CssOverride←'/Styles/style.css'
      ⍝ wrapper←'.wrapper'Body.Push _.div
      ⍝ menu←'.main-nav'wrapper.Add _.nav
      ⍝ mul←menu.Add _.ul
      ⍝ (mul.Add _.li).Add _.a'Home' 'href="/"'
      ⍝ (mul.Add _.li).Add _.a'Lounge' 'href="#"'
      ⍝ (mul.Add _.li).Add _.a'Bedroom' 'href="#"'
      ⍝ (mul.Add _.li).Add _.a'Sensors' 'href="#"'
      ⍝ (mul.Add _.li).Add _.a'Logs' 'href="#"'
     
     
   ⍝ ⍝ wrap the content of the body element in two divs
   ⍝    '#contentblock'Body.Push _.div
   ⍝    ⍝'#bodyblock'Body.Push _.div
     
   ⍝ ⍝ add the header to the top of the page
   ⍝    header←'#banner'Insert _.header
   ⍝    home←header.Add _.A'Heatherbank' '/' ⍝ click to go home
   ⍝    'src="/Styles/Images/duck.png"'home.Insert _.img ⍝ logo
   ⍝    menu←'#menu'header.Add _.nav
   ⍝    {menu.Add _.A ⍵('/',⍵)}¨'Products' 'Support' 'Corporate'
     
   ⍝ ⍝ Add a bar under the menu item that is currently open
   ⍝    Add _.style('#menu a[href="',_Request.OrigPage,'"] {border-bottom: 0.25em solid;}')
     
   ⍝ ⍝ call the base class Wrap function
      r←⎕BASE.Wrap
    ∇

:EndClass
