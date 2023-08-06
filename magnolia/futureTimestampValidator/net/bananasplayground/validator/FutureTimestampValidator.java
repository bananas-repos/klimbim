package net.bananasplayground.validator;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.temporal.TemporalAmount;

import org.apache.commons.lang3.StringUtils;

import com.vaadin.data.ValidationResult;
import com.vaadin.data.ValueContext;
import com.vaadin.data.validator.AbstractValidator;

/**
 * Klimbim Software collection, A bag full of things
 * Copyright (C) 2011-2023 Johannes 'Banana' Keßler
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * @see net.bananasplayground.validator.FutureTimestampDefinition
 */

public class FutureTimestampValidator extends AbstractValidator<LocalDateTime> {

    private final String errorMessage;
    private final String timeToAdd;

    protected FutureTimestampValidator(String errorMessage, String timeToAdd) {
        super(errorMessage);
        this.errorMessage = errorMessage;
        this.timeToAdd = timeToAdd;
    }

    @Override
    public ValidationResult apply(LocalDateTime value, ValueContext context) {
        if(StringUtils.isBlank(timeToAdd)) return ValidationResult.ok();
        boolean isValid = false;

        // date-based units (year, month, week, day) are denoted with uppercase abbreviations
        // (Y, M, W and D) while the time-based ones (hour and minute) are lowercase (h and m).
        // Test the case of the last character of the string to decide whether to parse into
        // a Period or a Duration. I exploit the fact that both of Period.parse and Duration.parse
        // accept the letters in either case.
        TemporalAmount toAddToCurrentDateTime;
        if (Character.isUpperCase(timeToAdd.charAt(timeToAdd.length() - 1))) {
            toAddToCurrentDateTime = Period.parse("P" + timeToAdd);
        } else {
            toAddToCurrentDateTime = Duration.parse("PT" + timeToAdd);
        }

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime futureDateTime = now.plus(toAddToCurrentDateTime);
        if(value.isEqual(futureDateTime) || value.isAfter(futureDateTime)) {
            isValid = true;
        }

        return isValid ? ValidationResult.ok() : ValidationResult.error(this.errorMessage);
    }
}
