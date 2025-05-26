use starknet::ContractAddress;

#[starknet::interface]
trait IReward<TContractState> {

    fn addPoints(ref self: TContractState, point: u256) -> bool;
    fn redeemPoints(ref self: TContractState, point: u256) -> bool;
    fn transferPoints(ref self: TContractState, to: ContractAddress, point: u256) -> bool; 
    fn getPoints(self: @TContractState, owner: ContractAddress) -> u256;
}

#[starknet::contract]
mod Reward {
    use super::IReward;
    use starknet::{ContractAddress, get_caller_address};
    use starknet::storage::{Map, StorageMapWriteAccess, StorageMapReadAccess};
    use core::num::traits::Zero;

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        PointsAdded: pointsAdded,
        RewardsClaimed: rewardsClaimed
    }

    #[derive(Drop, starknet::Event)]
    struct pointsAdded {
        owner: ContractAddress,
        points: u256
    }

    #[derive(Drop, starknet::Event)]
    struct rewardsClaimed {
        points: u256
    }

    #[storage]
    struct Storage {
        balances: Map<ContractAddress, u256>
    }

    #[abi(embed_v0)]
    impl RewardImpl of IReward<ContractState> {
        fn addPoints(ref self: ContractState, point: u256) -> bool {
            assert!(point != 0, "Zero Point Not Valid");
            self.balances.write(get_caller_address(), point);
            self.emit(pointsAdded { owner:get_caller_address(), points: point });
            true
        }

        fn redeemPoints(ref self: ContractState, point:u256) -> bool {
            let balance = self.balances.read(get_caller_address());
            assert!( balance >= point, "Insufficient balance");
            self.balances.write(get_caller_address() ,balance - point);
            self.emit(rewardsClaimed { points: point });
            true
        }

        fn transferPoints(ref self: ContractState, to: ContractAddress, point: u256) -> bool {
            let balance = self.balances.read(get_caller_address());
            assert!( balance >= point, "Insufficient balance");
            assert!( to.is_non_zero(), "Zero Address");

            let toBalance = self.balances.read(to);
            self.balances.write(get_caller_address(), balance-point);
            self.balances.write(to, toBalance + point);
            true

        }

        fn getPoints(self: @ContractState, owner: ContractAddress) -> u256 {
            assert!( owner.is_non_zero(), "Zero Address");
            self.balances.read(owner)
        }

    }

}











// /// Interface representing `HelloContract`.
// /// This interface allows modification and retrieval of the contract balance.
// #[starknet::interface]
// pub trait IHelloStarknet<TContractState> {
//     /// Increase contract balance.
//     fn increase_balance(ref self: TContractState, amount: felt252);
//     /// Retrieve contract balance.
//     fn get_balance(self: @TContractState) -> felt252;
// }

// /// Simple contract for managing balance.
// #[starknet::contract]
// mod HelloStarknet {
//     use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

//     #[storage]
//     struct Storage {
//         balance: felt252,
//     }

//     #[abi(embed_v0)]
//     impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
//         fn increase_balance(ref self: ContractState, amount: felt252) {
//             assert(amount != 0, 'Amount cannot be 0');
//             self.balance.write(self.balance.read() + amount);
//         }

//         fn get_balance(self: @ContractState) -> felt252 {
//             self.balance.read()
//         }
//     }
// }
