//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Event_Organization{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemaining;
    }

    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public nextId;
    
    function createEvent (string memory name, uint date, uint price,uint ticketCount) external {
        require(date>block.timestamp, "You can organize the event for the future date only");
        require(ticketCount>0,"Ticket size can't be zero");

        
        events[nextId]= Event(msg.sender,name,date,price,ticketCount,ticketCount);
        nextId++;
    }
    
        function buyTicket(uint id, uint quantity) external payable{
        require(events[id].date!=0,"This event does not exist");
        require(block.timestamp<events[id].date,"The event has already been occured");
        Event storage _event=events[id];
        require(_event.ticketRemaining>=quantity,"Not enough tickets left");
        _event.ticketRemaining-=quantity;
        tickets[msg.sender][id]+=quantity;
    }
}
