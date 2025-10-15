module counter::simple_counter{
    use std::signer;
    use std::debug;
    use std::error;
    use std::vector;

    struct Counter has key{
        value: u64,
    }

    
    public fun init(account: &signer) {
        move_to(account, Counter { value: 0 });
        debug::print(&vector::singleton(b"Counter initialized!"));
    }

  
    public fun increment(account: &signer) acquires Counter {
        let counter = borrow_global_mut<Counter>(signer::address_of(account));
        counter.value = counter.value + 1;
        debug::print(&vector::singleton(b"Counter incremented!"));
    }

   
    public fun decrement(account: &signer) acquires Counter {
        let counter = borrow_global_mut<Counter>(signer::address_of(account));
        if (counter.value > 0) {
              counter.value = counter.value - 1;
              debug::print(&vector::singleton(b"Counter decremented!"));
        } else {
              debug::print(&vector::singleton(b"Counter is already 0!"));
        };
    }

  
    public fun get(account: address): u64 acquires Counter {
          borrow_global<Counter>(account).value
    }
}
