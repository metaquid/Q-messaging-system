// Q messaging system
// by SMZ
// MIT licence

import Nat "mo:base/Nat";

/*
import Char "mo:base/Char";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
*/

actor {

	// channel initialization
	stable var value0 = 0;		// number of line message
	stable var chain0txt = "";		// resettable chain of messages - block of message
	stable var global0txt = "";		// non resettable chain of messages - chain of block of message

	stable var value1 = 0;
	stable var chain1txt = "";
	stable var global1txt = "";

	stable var value2 = 0;
	stable var chain2txt = "";
	stable var global2txt = "";

	stable var value3 = 0;
	stable var chain3txt = "";
	stable var global3txt = "";

	stable var value4 = 0;
	stable var chain4txt = "";
	stable var global4txt = "";

	stable var value5 = 0;
	stable var chain5txt = "";
	stable var global5txt = "";

	stable var value6 = 0;
	stable var chain6txt = "";
	stable var global6txt = "";

	stable var value7 = 0;
	stable var chain7txt = "";
	stable var global7txt = "";

	stable var value8 = 0;
	stable var chain8txt = "";
	stable var global8txt = "";

	stable var value9 = 0;
	stable var chain9txt = "";
	stable var global9txt = "";

	// local session choice initialization
	stable var valueN = 0;		// number position of actual message
	stable var chaintxt = "";		// content of all actual channel message

	// sysop setting
	stable var maxlenM = 80;		// max lenght for text message
	stable var maxlenR = 100;		// max number of line message before reset


/*
	// not solved conflict with old library !
	// service function
	public query func subText(value : Text, indexStart : Nat, indexEnd : Nat) : async Text {
		if (indexStart == 0 and indexEnd >= value.size()) {
			return value;
		} else if (indexStart >= value.size()) {
			return "";
		};
    
		var indexEndValid = indexEnd;
		if (indexEnd > value.size()) {
			indexEndValid := value.size();
		};

		var result : Text = "";
		var iter = Iter.toArray<Char>(Text.toIter(value));
		for (index in Iter.range(indexStart, indexEndValid - 1)) {
			result := result # Char.toText(iter[index]);
		};

		result;
	};
*/


	// master function
	public func news(channel : Text, message : Text) : async Text {

		// message is transformed in mess inside the function

		var mess : Text = "";

		// filtering logic

		// filtering lenght
		if (message.size() > maxlenM) {
			//mess := subText(message, 0, maxlenM);		// resolve problem
			//mess := stripEnd(message, PATTERN);		// define PATTERN
			mess := "MESSAGE TOO LONG !";
		} else {
			mess := message;
		};

		// use mess from this point and not message

		// filtering bad words
		//mess := replace(mess, "fuck", "f**k");			// resolve problem

		// filtering contains substring
		//

		// update of page
		if (message.size() == 0) {

			if (channel == "0") {
				return chain0txt;
			} else if (channel == "1") {
				return chain1txt;
			} else if (channel == "2") {
				return chain2txt;
			} else if (channel == "3") {
				return chain3txt;
			} else if (channel == "4") {
				return chain4txt;
			} else if (channel == "5") {
				return chain5txt;
			} else if (channel == "6") {
				return chain6txt;
			} else if (channel == "7") {
				return chain7txt;
			} else if (channel == "8") {
				return chain8txt;
			} else if (channel == "9") {
				return chain9txt;
			};

		} else {

			// setting for channel id
			if (channel == "0") {
				valueN := value0;
				chaintxt := chain0txt;
			} else if (channel == "1") {
				valueN := value1;
				chaintxt := chain1txt;
			} else if (channel == "2") {
				valueN := value2;
				chaintxt := chain2txt;
			} else if (channel == "3") {
				valueN := value3;
				chaintxt := chain3txt;
			} else if (channel == "4") {
				valueN := value4;
				chaintxt := chain4txt;
			} else if (channel == "5") {
				valueN := value5;
				chaintxt := chain5txt;
			} else if (channel == "6") {
				valueN := value6;
				chaintxt := chain6txt;
			} else if (channel == "7") {
				valueN := value7;
				chaintxt := chain7txt;
			} else if (channel == "8") {
				valueN := value8;
				chaintxt := chain8txt;
			} else if (channel == "9") {
				valueN := value9;
				chaintxt := chain9txt;
			};

		};
		
		if (valueN >= maxlenR) {
			// reset the system when arrive to limit maxlenR
			// but before, we preserve the content in chaintxt, and put in the right globalNtxt
			// chaintxt is now a full container of message and we reverse it on the right globalNtxt
			if (channel == "0") {
				global0txt := chaintxt # global0txt;
			} else if (channel == "1") {
				global1txt := chaintxt # global1txt;
			} else if (channel == "2") {
				global2txt := chaintxt # global2txt;
			} else if (channel == "3") {
				global3txt := chaintxt # global3txt;
			} else if (channel == "4") {
				global4txt := chaintxt # global4txt;
			} else if (channel == "5") {
				global5txt := chaintxt # global5txt;
			} else if (channel == "6") {
				global6txt := chaintxt # global6txt;
			} else if (channel == "7") {
				global7txt := chaintxt # global7txt;
			} else if (channel == "8") {
				global8txt := chaintxt # global8txt;
			} else if (channel == "9") {
				global9txt := chaintxt # global9txt;
			};
			valueN := 0;
			chaintxt := "";
		} else {
			valueN += 1;
		};

		// conversion of progressive number of the message
		var valueT = Nat.toText(valueN);
		if (valueN < 10) {
			valueT := "0" # valueT;
		};

		// how to show results
		if (false) {
			// tail
			chaintxt #= "\n" # valueT # ": " # mess;
		} else {
			// stack
			chaintxt := valueT # ": " # mess # "\n" # chaintxt;
		};

		if (channel == "0") {
			value0 := valueN;
			chain0txt := chaintxt;
		} else if (channel == "1") {
			value1 := valueN;
			chain1txt := chaintxt;
		} else if (channel == "2") {
			value2 := valueN;
			chain2txt := chaintxt;
		} else if (channel == "3") {
			value3 := valueN;
			chain3txt := chaintxt;
		} else if (channel == "4") {
			value4 := valueN;
			chain4txt := chaintxt;
		} else if (channel == "5") {
			value5 := valueN;
			chain5txt := chaintxt;
		} else if (channel == "6") {
			value6 := valueN;
			chain6txt := chaintxt;
		} else if (channel == "7") {
			value7 := valueN;
			chain7txt := chaintxt;
		} else if (channel == "8") {
			value8 := valueN;
			chain8txt := chaintxt;
		} else if (channel == "9") {
			value9 := valueN;
			chain9txt := chaintxt;
		};

		return chaintxt;
	};

};
