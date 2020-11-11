enum TimeKeeperType {
    TK_Atomic, TK_Water, TK_Wrist
};

class TimeKeeper {
    public:
        //TimeKeeper();
        //~TimeKeeper();
        static TimeKeeper* Create(TimeKeeperType type);
        virtual void printTime() = 0;
    protected:
        std::string timeText;

};

class AtomicClock: public TimeKeeper {
    public :
        AtomicClock(){
            timeText = "Jest 4:20, skrecaj blanta";
        };
        void printTime(){
            std::cout << timeText << std::endl;
        }
};

class WaterClock: public TimeKeeper {
    public :
        WaterClock(){
            timeText = "W pół do komina";
        }
        void printTime(){
            std::cout << timeText << std::endl;
        }
};

class WristWatch: public TimeKeeper {
    public :
        WristWatch (){
            timeText = "Twoja ostatnia";
        }
        void printTime(){
            std::cout << timeText << std::endl;
        }
};

TimeKeeper* TimeKeeper::Create(TimeKeeperType type){
    if (type == TK_Atomic)
        return new AtomicClock();
    else if (type == TK_Water)
        return new WaterClock();
    else if (type == TK_Wrist)
        return new WristWatch();
    else return NULL;
}

