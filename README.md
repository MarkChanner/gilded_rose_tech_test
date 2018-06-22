# Gilded Rose tech test

\*"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a _sell_in_ value which denotes the number of days we have to sell the item. All items have a _quality_ value which denotes how valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:

* Once the sell by date has passed, quality degrades twice as fast
* The quality of an item is never negative
* “Aged Brie” actually increases in quality the older it gets
* The quality of an item is never more than 50
* “Sulfuras”, being a legendary item, never has to be sold or decreases in quality
* “Backstage passes”, like aged brie, increases in quality as it’s _sell_in_ value approaches; _quality_ increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

* “Conjured” items degrade in quality twice as fast as normal items

Feel free to make any changes to the _update_quality_ method and add any new code as long as everything still works correctly. However, do not alter the Item class or _items_ property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership"\*

## The brief:

Refactor the code in such a way that adding the new "conjured" functionality is easy.

## Running the Program

Require the files:

```
require './lib/item.rb'
require './lib/backstage_pass_item'
require './lib/brie_item'
require './lib/conjured_item'
require './lib/gilded_rose'
require './lib/item'
require './lib/normal_item'
require './lib/sulfuras_item'
```

Instantiate the objects:
_Order of arguments is name, sell_in, quality_

```
backstage_pass = BackstagePassItem.new("Backstage passes to a TAFKAL80ETC concert", 6, 2)
brie = BrieItem.new("Aged Brie", 5, 2)
conjured = ConjuredItem.new("Conjured", 5, 4)
normal = NormalItem.new("foo", 8, 0)
sulfuras = SulfurasItem.new("Sulfuras, Hand of Ragnaros", 3, 5)
items = [backstage_pass, brie, conjured, normal, sulfuras]
gilded_rose = GildedRose.new(items)
gilded_rose.update_quality
```
