package net.bananasplayground.validator;

import info.magnolia.ui.field.ConfiguredFieldValidatorDefinition;
import info.magnolia.ui.field.ValidatorType;
import lombok.Getter;
import lombok.Setter;

/**
 * Check if given datetime is between given timeframe of that date(day)
 *
 * works on LocalDateTime object
 *
 * timeframe:
 *   $type: timeframe
 *   timeFrom: "HH:MM"
 *   timeTo: "HH:MM"
 *   errorMessage: bla
 */

@Getter
@Setter
@ValidatorType("timeframe")
public class TimeFrameValidatorDefinition extends ConfiguredFieldValidatorDefinition {

    private String timeTo;
    private String timeFrom;

    public TimeFrameValidatorDefinition() {
        setFactoryClass(TimeFrameValidatorFactory.class);
    }
}
