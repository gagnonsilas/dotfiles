{ ... }:
{

  programs.firefox = {
    enable = true;
    profiles = {
      silas = {
        userChrome = ''
.titlebar-buttonbox-container{ display:none } 

:root[tabsintitlebar]{
  --uc-window-control-width: 138px; /* Space reserved for window controls */
  --uc-window-drag-space-width: 32px; /* Extra space reserved on both sides of the nav-bar to be able to drag the window */
}

#nav-bar{
  padding-right: calc(var(--uc-window-control-width,0px) + var(--uc-window-drag-space-width,0px));
  padding-left: var(--uc-window-drag-space-width,0px);
  padding-top: 0px !important;
  border-color: #00000080;
}

:root{ --uc-toolbar-height: 40px; }

#TabsToolbar{ visibility: collapse !important }

:root:not([inFullscreen]) #nav-bar{
  margin-top: calc(0px - var(--uc-toolbar-height));
}

#toolbar-menubar{
  min-height:unset !important;
  height:var(--uc-toolbar-height) !important;
  position: relative;
  color: rgb(182, 98, 59);
}

#main-menubar{
  display: none;
}

:root {
  --thin-tab-width: 80px;
  --wide-tab-width: 200px;
}

#sidebar-header {
  visibility: collapse;
}

#sidebar {
  max-width: none !important;
  min-width: var(--thin-tab-width) !important; /* TODO: set min width to collapsed */
}

#sidebar-box + #sidebar-splitter {
  display: none !important;
}


#sidebar-box:not {
  min-width: var(--wide-tab-width) !important;
  max-width: none !important;
}

#sidebar-box {
  position: relative !important;
  transition-property: all;
  transition-duration: 100ms;
  transition-delay: 250ms !important;
  min-width: var(--thin-tab-width) !important;
  max-width: var(--thin-tab-width) !important;
  z-index: 2;

}
#sidebar-box:hover {
  transition-delay: 250ms !important; /*hover delay for avoiding accidental expansion on mouse hover*/
  min-width: var(--wide-tab-width) !important;
  max-width: var(--wide-tab-width) !important;
  margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
}

#PersonalToolbar{
  margin-left: 0;
  --uc-bm-height: 20px; /* Might need to adjust if the toolbar has other buttons */
  --uc-bm-padding: 4px; /* Vertical padding to be applied to bookmarks */
  /* --uc-autohide-toolbar-delay: 250ms; The toolbar is hidden after 0.25s */
}

/* #PersonalToolbar:not([customizing]){
  position: relative;
  margin-bottom: calc(0px - var(--uc-bm-height) - 2 * var(--uc-bm-padding));
  transform: scaleY(0);
  transform-origin: top;
  transition: transform 135ms linear var(--uc-autohide-toolbar-delay) !important;
  z-index: 1;
} */

#nav-bar:focus-within + #PersonalToolbar{
  transition-delay: 100ms !important;
  transform: scaleY(1);
}

#navigator-toolbox:hover > #PersonalToolbar{
  transition-delay: 100ms !important;
  transform: scaleY(1);
}

#navigator-toolbox:hover > #nav-bar:focus-within + #PersonalToolbar {  
  transform: scaleY(1);
}

#navigator-toolbox[inFullscreen="true"] #PersonalToolbar {
  visibility: unset !important;
}
        '';
      };
    };
  };
}
