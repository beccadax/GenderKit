GenderKit
=======

GenderKit is a set of types, controls, and functions for working with the genders of 
users and other human beings. It seeks to make working correctly with genders as 
simple, straightforward, and type-safe as possible.

It includes the following components:

* A `Gender` enum for expressing user genders.
* A `PronounSet` type and a series of helper functions to help you generate 
  grammatically correct and friendly user interface text in English.
* A `GenderField` control that allows the user to choose their gender.

GenderKit supports non-binary genders with arbitrary, user-specified names and 
pronoun sets. It attempts to make supporting less common gender identities just as 
easy as working with the ones everybody is familiar with. 

GenderKit is written in Swift and heavily uses Swift-specific features. It currently 
supports only iOS, but AppKit versions of `GenderField` and associated UI could 
probably be added without too much difficulty.

GenderKit is currently prerelease software, and is not yet production-ready.

The `Gender` type
-------------

The `Gender` type represents a user's gender. Gender is not the same as biological 
sex; it encompasses how a person sees themself and wants to be perceived by 
others. Outside of medicine, gender is almost always the relevant variable to 
capture.

`Gender` is an enum with three cases: `Male`, `Female`, and `Other`. Each 
`Gender` has a `description`—a name such as "Male" or "Female"—and a set of 
`pronouns` appropriate to that gender. The `Other` case includes the description 
and pronouns as associated values, allowing you to express each person's preferred 
gender identity.

`Gender` conforms to `Equatable`; `Other` genders are considered equal if their 
descriptions are equal. It does not conform to `Comparable`. If you need to group 
people by gender, I recommend sorting on their `Gender.description` property.

`Gender` conforms to `RawRepresentable`, converting to and from `String`. Male 
and Female are represented as the strings "M" and "F"; Other is represented by a 
string beginning with "O", followed by the description, a pipe character as a 
separator, and JSON data representing the person's preferred pronouns. This 
representation is designed to make it relatively easy to work with a gender's raw
representation on platforms where GenderKit is not available.

Pronoun support
-----------

Each `Gender` has an associated `PronounSet`. The `PronounSet` encompasses four 
pronouns for different situations: `subject`, `object`, `possessiveDeterminer`, and 
`determiner`.

You probably don't know what those terms mean, and neither does anyone else, so 
GenderKit includes a set of helper functions that make it easy to construct a 
sentence with pronouns:

    "\(They(user.gender.pronouns)) let me go to \(their(user.gender.pronouns)) house."

There are eight helper functions of this sort: `They`, `they`, `Them`, `them`, 
`Their`, `their`, `Theirs`, and `theirs`. The versions with initial caps should be 
used at the beginning of a sentence; the all-lowercase ones should be used 
elsewhere. Although these functions are named with the often-plural "they" set of 
pronouns, they should be treated as singular. (There are certain ambiguities in 
both the "he" and "she" pronouns that prevent their use for this task.)

These helper methods take an instance conforming to the `PronounReferable` 
protocol. `Gender` conforms to `PronounReferable`, so you can just specify a 
`Gender` instance instead of a `PronounSet`:

    "\(They(user.gender)) let me go to \(their(user.gender)) house."

You can also make your own model objects conform to `PronounReferable` by adding 
a `pronouns` property. This allows you to construct text in a very readable way:

    "\(They(user)) let me go to \(their(user)) house."

Pronoun sets can only do so much: they can't adjust the pluralization or grammar of 
other parts of the sentence or express novel pronoun grammar that's too dissimilar 
from standard pronouns. They can express always-lowercase pronouns but not 
always-uppercase ones. They are not designed to express the semantics of 
languages other than English.

GenderField
--------

GenderKit includes a `GenderField` to permit users to specify their gender.

The `GenderField` is shown as a segmented control with three options: "Male", 
"Female", and "Other". Choosing "Other" will display a screen (in a popover on
iPad or a modal dialog on iPhone) that allows the user to specify their gender 
description and preferred pronouns. Once this screen is dismissed, the "Other" 
button's label changes to their gender's description. They can tap the button again 
to further edit it.

The user's chosen gender may be found in the field's `selectedGender` property. 
`GenderField` is a subclass of `UIControl`, and uses the usual target-action 
mechanisms to inform you of edits.

Contributing
=========

Contributions are welcome, and should be submitted through the GenderKit
[GitHub project](https://github.com/brentdax/GenderKit). I will not accept 
requests to remove support for non-binary genders. If you want to do that, fork the 
project. (Suggestions for improving that support, on the other hand, are perfectly 
welcome.)

If you are a non-programmer and don't have a GitHub account, please send 
comments to the email address listed below.

Author
=====

Brent Royal-Gordon, Architechies \<brent@architechies.com\>. If you use this 
framework in one of your own projects, I would love to hear from you.

If I'm doing something wrong, please be patient with me—write to me and I'll see
what I can do. I'm a cis guy with limited exposure to non-binary people; I consider 
this project to be both an interesting engineering challenge and an opportunity to 
make it so easy to support a wider spectrum of gender identities that developers 
won't have an excuse not to. 

Copyright
=======

(C) 2014 Architechies. Distributed under the MIT License.

> Permission is hereby granted, free of charge, to any person obtaining a copy 
> of this software and associated documentation files (the "Software"), to deal 
> in the Software without restriction, including without limitation the rights to 
> use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
> of the Software, and to permit persons to whom the Software is furnished to do 
> so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all 
> copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
> OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
> FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
> IN THE SOFTWARE.
