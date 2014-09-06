import UIKit
import GenderKit
import XCPlayground

// 
// GenderKit includes a Gender enum which represents a
// person's gender. Gender can be Male, Female, or 
// Other, with Other carrying a custom set of pronouns.
// 
let gender = Gender.Male
//let gender = Gender.Female
//let gender = Gender.Other(description: "Agender", pronouns: PronounSet(subject: "They", object: "Them", possessiveDeterminer: "Their", determiner: "Theirs"))
gender.description

// 
// Easily construct sentences with pronouns appropriate
// for a particular gender using the pronoun helper 
// functions.
//
"\(They(gender)) let me go to \(their(gender)) house."

//
// You can make your own model classes conform to 
// PronounReferable to allow for easier use of the 
// pronoun helper functions.
//
class User: PronounReferable {
    var userGender = gender
    
    var pronouns: PronounSet {
        return userGender.pronouns
    }
}
let myUser = User()

"\(They(myUser)) took me to \(their(myUser)) house."

// 
// The GenderField gives you a simple control for 
// choosing a gender.
// 
let field = GenderField(frame: CGRect(x: 0, y: 0, width: 300, height: 24))
//field.explicitlyAllowsNone = true
field.selectedGender = gender
XCPShowView("GenderField", field)
// 
// Tapping "Other" displays a gender designer allowing 
// the user to specify their preferred gender identity 
// and pronouns, but this feature can't be demoed in 
// a Playground.
// 

// 
// Genders are RawRepresentable as Strings; the 
// representation is "M" for Male, "F" for Female, or 
// "O(description)|(pronoun JSON data)" for Other.
// 
let raw = gender.toRaw()
Gender.fromRaw(raw)!
