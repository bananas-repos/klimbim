package net.bananasplayground.validator;

import info.magnolia.ui.field.ConfiguredFieldValidatorDefinition;
import info.magnolia.ui.field.ValidatorType;
import lombok.Getter;
import lombok.Setter;

/**
 * Checks if datetime selection is >= now+timeToAdd
 *
 * works on LocalDateTime object
 *
 * timeToAdd time in lowercase, date uppercase
 * timeToAdd: 1h|2D
 *
 * futureDate:
 *  $type: futureTimestamp
 *  timeToAdd: 1h
 *  errorMessage: bla
 *
 */

@Getter
@Setter
@ValidatorType("futureTimestamp")
public class FutureTimestampDefinition extends ConfiguredFieldValidatorDefinition {

    private String timeToAdd;

    public FutureTimestampDefinition() {
        setFactoryClass(FutureTimestampFactory.class);
    }
}
