import UIKit
import GenderKit
import XCPlayground

// 
// GenderKit includes a Gender enum which represents a
// person's gender. Gender can be Male, Female, or 
// Other, with Other carrying a custom set of pronouns.
// 
//let gender = Gender.Male
let gender = Gender.Female
//let gender = Gender.Other(GenderLexicon(gender: "Agender", subjectPronoun: "They", objectPronoun: "Them", possessiveDeterminerPronoun: "Their", possessivePronoun: "Theirs"))
gender.description

// 
// Easily construct sentences with words appropriate
// to a particular gender using InflectableString and  
// the InflectableTerm constants.
//
inflect("\(They) let me go to \(their) house.", forGender: gender)

// 
// You can inflect a sentence that refers to several 
// different people, too.
// 
inflect("\(They[0]) took me to \(their[1]) house.", forGenders: Gender.Male, Gender.Female)

//
// You can make your own model classes conform to 
// PronounReferable to allow for easier use of the 
// inflection features.
//
class User: Genderable {
    var userGender = gender
    
    var genderLexicon: GenderLexicon {
        return userGender.genderLexicon
    }
}
let myUser = User()

inflect("\(They) took me to \(their) house.", forGender: myUser)

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
Gender.fromRaw(raw)!.description
