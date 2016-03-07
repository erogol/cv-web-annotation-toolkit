# Introduction #

A menu is a simple list of images. Each image corresponds to the item the user can choose. They choose it by clicking the item. Once the item has been chosen, the menu reports the item to the robot and the menu becomes inactive.

The menu can be activated with GET requests and the images can be added to a menu through POST reqests.

# Operations #

See all menus:
> `http://vm7.willowgarage.com/web_menu/all/`

Activate menu:
> `http://vm7.willowgarage.com/web_menu/enableMenu/<MENU_CODE>/`

Choose from menu:
> `http://vm7.willowgarage.com/web_menu/m/<MENU_CODE>/`

POST image:
> `http://vm7.willowgarage.com/web_menu/newImage/<MENU_CODE>/`

Clear all images:
> `http://vm7.willowgarage.com/web_menu/clearImages/<MENU_CODE>/`

For your server, replace vm7.willowgarage.com with your server name.

The images are stored in settings.WEBMENU\_ROOT +"menus/".

# Future features #

  * Sample tutorial with the robot simulator
  * Submitting single image manually for ease of testing.
  * Shopping basket, nifty drag-n-drop
  * Pricing and billing. Cross-country shipping and door-to-door delivery.